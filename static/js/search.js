
/**
 * @typedef {{
*  label   : string,
*  count   : number,
*  selected: boolean
* }} SearchFilter
* 
* @typedef {{
*  results: Array,
*  filters: { FILTER_CATEGORY: SearchFilter[] }
* }} SearchResult
*/

class SearchController {
   #view  = new SearchView(this);
   #model = new SearchModel();

    constructor(){
       // Prepare the search API (if not already done):
       this.initSearchAPI();
       // Focus on the search field:
       this.#view.focusOnSearchForm();
    }

   initSearchAPI(){
       this.#model.loadPageFind();
   }

   search(terms){
       // No terms => no result area:
       if (this.#isEmptySearch(terms))
       {
           this.#view.clearSearchResults();
       }
       // If terms have changed, run the real search:
       else if (this.#isDifferentSearch(terms))
       {
           this.#setSearchTerms(terms);
           this.#runSearch();
       }
   }

   #isEmptySearch(terms){
       return (terms.trim().length == 0);
   }

   #isDifferentSearch(terms){
       return (this.#model.terms != terms);
   }

   #setSearchTerms(terms){
       this.#model.terms = terms;
   }

   #runSearch(){
       this.#view.clearSearchResults();

       this.#model.search()
       
       .then(searchResults => {
           this.#view.showResults(searchResults.results);
           this.#view.showFilters(searchResults.filters, this.#model.getSearchResultFilters());
       })
       
       .catch(err => console.error(`ERROR: failed to search pages for '${this.#model.terms}'!`, err));
   }

   toggleFilter(filterCategory, filterLabel){
       if (this.#model.isFilterSet(filterCategory, filterLabel))
           this.#model.unsetFilter(filterCategory, filterLabel);
       else
           this.#model.setFilter(filterCategory, filterLabel);
       
       this.#runSearch();
   }

   clearSearch(){
       this.#model.clear();
   }
}

class SearchModel {
   /** @type {Object} */
   #pagefind = null;
   
   /** @type {string} */
   #terms    = null;

   /**@type {{ "FILTER_CATEGORY": SearchFilter[] }} */
   #filters  = {};

   static #SCORE_MIN   = 0; // TODO Maybe no more needed!
   static #MAX_RESULTS = 50;

   loadPageFind(){
       if (this.#pagefind == null) {
           import("../pagefind/pagefind.js")
           .then(pf => this.#initPageFind(pf));
       }
   }

   #initPageFind(pf){
       this.#pagefind = pf;
       this.#pagefind.init()
       .then(() => this.#pagefind.filters());
   }

   get terms(){ return this.#terms; }
   set terms(terms){ this.#terms = terms; }

   isFilterSet(filterCategory, filterLabel){
       return this.#filters[filterCategory] && this.#filters[filterCategory].includes(filterLabel);
   }

   setFilter(filterCategory, filterLabel){
       if (filterCategory && filterLabel && !this.isFilterSet(filterCategory, filterLabel)){
           if (!this.#filters[filterCategory])
               this.#filters[filterCategory] = [filterLabel];
           else
               this.#filters[filterCategory].push(filterLabel);
       }
   }

   unsetFilter(filterCategory, filterLabel){
       if (filterCategory && filterLabel && this.isFilterSet(filterCategory, filterLabel)){
           this.#filters[filterCategory].splice(this.#filters[filterCategory].indexOf(filterLabel), 1);
           if (this.#filters[filterCategory].length == 0)
               delete this.#filters[filterCategory];
       }
   }

   getSearchResultFilters(){
       const resultFilters = {};
       Object.keys(this.#filters)
       .forEach(filterCategory => {
           resultFilters[filterCategory] = this.#filters[filterCategory]
                                           .map(filterLabel => {return {
                                               "label"   : filterLabel,
                                               "selected": true,
                                               "count"   : 0
                                           }});
       });
       return resultFilters;
   }

   /**
    * 
    * @returns {Promise<SearchResult>}
    */
   async search(){
       return this.#pagefind.search(this.#terms, { 'filters': this.#filters })
                            .then(rawResults => this.#rewriteResults(rawResults))
                            .then(searchResults => this.#filterResults(searchResults));
   }

   /**
    * 
    * @param {Object} rawResults 
    * @returns {SearchResult}
    */
   #rewriteResults(rawResults){
       if (rawResults)
           return {
               "results": rawResults.results,
               "filters": this.#rewriteFilters(rawResults.filters)
           };
       else
           return { "results": [], "filters": {} };
   }

   /**
    * 
    * @param {Object} rawFilters 
    * @returns {{"FILTER_CATEGORY": SearchFilter[]}}
    */
   #rewriteFilters(rawFilters){
       const finalFilters = {};
       Object.entries(rawFilters)
             .forEach(([filterCategory, tags]) => {
                 finalFilters[filterCategory] = this.#rewriteTagArray(filterCategory, tags);
             });
       return finalFilters;
   }

   #rewriteTagArray(filterCategory, tags){
       const sectionTags = [];
       Object.entries(tags)
             .filter(([_, value]) => (value > 0))
             .forEach(([key, value]) => sectionTags.push({
                   "label"   : key,
                   "count"   : value,
                   "selected": this.isFilterSet(filterCategory, key)
             }));
       return sectionTags;
   }

   async #filterResults(searchResults){
       return Promise.all(
           searchResults.results.filter(r => (r.score >= SearchModel.#SCORE_MIN))
                                .slice(0, SearchModel.#MAX_RESULTS)
                                .map(r => r.data())
       )
       .then(filteredResults => {
           searchResults.results = filteredResults.filter(result => result.meta && result.meta.date)
                                                  .map(result => { result.meta.date = this.#resolveDate(result.meta.date); return result })
                                                  .sort((r1, r2) => r2.meta.date - r1.meta.date);
           return searchResults;
       });
   }

   #resolveDate(dateStr){
       if (dateStr && typeof(dateStr) == 'string')
           return new Date(dateStr.replaceAll('&#32;', ' ').replaceAll('&#43;', '+'));
       else
           return dateStr;
   }

   clear(){
       this.#terms   = null;
       this.#filters = {};
   }
}

class SearchView
{
   #controller;

   #debounceSearchTimer = null;

   static #DEBOUNCE_SEARCH_TIMEOUT = 300;

   #elSearchParent     = document.querySelector('.search-container');
   #elSearchForm       = this.#elSearchParent.querySelector('.search-form');
   #elSearchField      = this.#elSearchForm.querySelector('input[type=text]');
   #elSearchResult     = this.#elSearchParent.querySelector('.search-result');
   #divMessageTerms    = this.#elSearchResult.querySelector('.message > .terms');
   #divFilters         = this.#elSearchResult.querySelector('.filters');
   #ulSearchResults    = this.#elSearchResult.querySelector('.results');

   constructor(searchController)
   {
       this.#controller = searchController;
       this.#initSearchEvents();
   }

   #debounceSearch(){
       clearTimeout(this.#debounceSearchTimer);
       this.#debounceSearchTimer = setTimeout(() => this.#controller.search(this.getSearchTerms()),
                                              SearchView.#DEBOUNCE_SEARCH_TIMEOUT);
   }

   #initSearchEvents(){
       /*
       * 'Esc' to hide the search form,
       * otherwise, start searching at each hit key.
       */
       this.#elSearchField.addEventListener('keyup', ()=>{
            this.#debounceSearch();
       });
   }

   getSearchTerms(){
       return this.#elSearchField.value;
   }

   focusOnSearchForm(){
        // set the focus on the search field, just after the appearing animation has started:
        setTimeout(() => this.#elSearchField.focus(), 100);
   }

   clearSearchResults(){
       this.#ulSearchResults.innerHTML = '';
       this.#elSearchResult.classList.remove('empty')
       this.#elSearchResult.classList.add('hidden');
   }

   #clearSearchFilters(){
       this.#divFilters.innerHTML = '';
   }

   showResults(results){
       this.#elSearchResult.classList.remove('hidden');
       if (results.length == 0){
           this.#elSearchResult.classList.add('empty');
           this.#divMessageTerms.innerText = this.getSearchTerms();
       }
       else
           this.#elSearchResult.classList.remove('empty');
       results.forEach(data => this.#appendResult(data));
   }

   #appendResult(result){
       const elMatch = document.createElement('li');

       const elImgContainer = document.createElement('div');
       elImgContainer.classList.add('page-img');
       const elImage = document.createElement('img');
       if (result.meta.image){
           let imgSrc = result.url+result.meta.image;
           if (result.meta.image.match('^((https?|ftp)://|/).*'))
               imgSrc = result.meta.image;
           elImage.setAttribute("src", imgSrc);
       }
       else
           elImage.setAttribute("src", `/images/ivoa_logo.png`);
       elImgContainer.appendChild(elImage);
       elMatch.appendChild(elImgContainer);
       
       const elPageDescription = document.createElement('description');
       elPageDescription.classList.add('page-desc')
       elMatch.appendChild(elPageDescription);

       const elTitle = document.createElement('a');
       elTitle.setAttribute('href', result.url);
       elTitle.setAttribute('target', '_blank');
       if (result.filters.section)
           elTitle.innerText = `[${result.filters.section}] `;
       else
           elTitle.innerText = '';
       elTitle.innerText += result.meta.title;
       elPageDescription.append(elTitle);

       const elExcerpt = document.createElement('div')
       elExcerpt.classList.add('excerpt');
       elExcerpt.innerHTML = result.excerpt;
       elPageDescription.appendChild(elExcerpt);

       const elTags = document.createElement('div');
       elTags.classList.add('tags');
       elPageDescription.appendChild(elTags);

       if (result.filters.tag){
           result.filters.tag.forEach(tag => {
               elTags.appendChild(this.#createTagElement(tag));
           });
       }

       if (result.meta.date){
           const elDate = document.createElement('span');
           elDate.classList.add('date');
           elDate.innerHTML = result.meta.date.toLocaleString();
           elTags.appendChild(elDate);
       }
       
       this.#ulSearchResults.append(elMatch);
   }

   #createTagElement(tagLabel, classes){
       const elTag = document.createElement('span');
       if (classes)
           elTag.setAttribute('class', classes);
       elTag.innerText = tagLabel;
       return elTag;
   }

   showFilters(filters, selectedFilters={}){
       this.#clearSearchFilters();
       if (this.#hasNoSelectedFilter(filters))
           filters = selectedFilters;
       Object.entries(filters).forEach(([section, tags]) => {
           this.#showFilterSection(section, tags)
       });
   }

   #hasNoSelectedFilter(filters){
       if (filters){
           const sumTags = Object.entries(filters)
                           .reduce((sum, [section, tags]) => sum + (tags ? tags.length : 0), 0);
           return sumTags <= 0;
       }else
           return true;
   }
   
   #showFilterSection(sectionLabel, tags){
       const divSection = document.createElement('div');
       divSection.classList.add('filter-category');
       divSection.setAttribute('data-category', sectionLabel);
       const eltSectionTitle = document.createElement('h3');
       eltSectionTitle.innerText = sectionLabel;
       divSection.appendChild(eltSectionTitle);
       const ulFilterValues = document.createElement('ul');
       tags.sort((t1, t2) => t1.label.localeCompare(t2.label))
           .forEach(tag => this.#appendFilterItems(sectionLabel, tag.label, tag.count, tag.selected, ulFilterValues));
       divSection.appendChild(ulFilterValues);
       this.#divFilters.appendChild(divSection);
   }
   
   #appendFilterItems(filterCategory, tagLabel, tagCount, tagSelected, ulFilterValues){
       const filterId = `filter-tag-${tagLabel}`;
       const liFilterValue = document.createElement('li');
       const chkFilter = document.createElement('input');
       chkFilter.setAttribute('id', filterId);
       chkFilter.setAttribute('name', filterId);
       chkFilter.setAttribute('type', 'checkbox');
       if (tagSelected)
           chkFilter.setAttribute('checked', 'checked')
       chkFilter.setAttribute('data-tag', tagLabel);
       chkFilter.addEventListener('click', ()=>this.#controller.toggleFilter(filterCategory, tagLabel));
       liFilterValue.appendChild(chkFilter);
       const lblFilter = document.createElement('label');
       lblFilter.setAttribute('for', filterId);
       lblFilter.innerHTML = `${tagLabel} <em>(${tagCount})</em>`;
       liFilterValue.appendChild(lblFilter);
       ulFilterValues.appendChild(liFilterValue);
   }

}

/**
* Public function to toggle the search form if any is available on the current
* page. If no search trigger/form is found, this function has no effect.
*/
function showSearchFormIfAny(){
   const searchTrigger = document.querySelector('.sitenavbar .search-trigger');
   if (searchTrigger)
       searchTrigger.click();
}

/* Initialize the Search feature: */
new SearchController();
