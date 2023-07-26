var MyDocType=new Array();
<!-- Document Type -->
MyDocType[0] = new Array();
MyDocType[0]["note"] = "IVOA Note";
MyDocType[0]["wd"] = "IVOA Working Draft";
MyDocType[0]["pr"] = "IVOA Proposed Recommendation";
MyDocType[0]["rec"] = "IVOA Recommendation";
MyDocType[0]["other"] = "Other";

<!-- URL -->
MyDocType[1] = new Array();
MyDocType[1]["none"] = "&lt;TBD&gt;";
MyDocType[1]["note"] = "NOTE";
MyDocType[1]["wd"] = "WD";
MyDocType[1]["pr"] = "PR";
MyDocType[1]["rec"] = "REC";
MyDocType[1]["other"] = "&lt;TBD&gt;"
MyDocType[1]["app"] = "App";
MyDocType[1]["dal"] = "DAL";
MyDocType[1]["dm"] = "DaM";
MyDocType[1]["gws"] = "GWS";
MyDocType[1]["reg"] = "ReR";
MyDocType[1]["std"] = "SDP";
MyDocType[1]["semantics"] = "semantics";
MyDocType[1]["the"] = "The";
MyDocType[1]["voe"] = "VOE";
MyDocType[1]["vot"] = "VOT";
MyDocType[1]["voq"] = "VQL";
MyDocType[1]["dcp"] = "DCP";

<!-- Status 2nde part -->
MyDocType[2] = new Array();
MyDocType[2]["note"] = 'This is an IVOA Note expressing suggestions from and opinions of the authors.<br/>It is intended to share best practices, possible approaches, or other perspectives on interoperability with the Virtual Observatory. It should not be referenced or otherwise interpreted as a standard specification.';
MyDocType[2]["wd"] = 'This is an IVOA Working Draft for review by IVOA members and other interested parties.<br/> It is a draft document and may be updated, replaced, or obsoleted by other documents at any time.It is inappropriate to use IVOA Working Drafts as reference materials or to cite them as other than "work in progress".';
MyDocType[2]["pr"] = 'This is an IVOA Proposed Recommendation made available for public review.<br/> It is appropriate to reference this document only as a recommended standard that is under review and which may be changed before it is accepted as a full recommendation.';
MyDocType[2]["rec"] = "<br/>It has been reviewed by IVOA Members and other interested parties, and has been endorsed by the IVOA Executive Committee as an IVOA Recommendation. It is a stable document and may be used as reference material or cited as a normative reference from another document. IVOA's role in making the Recommendation is to draw attention to the specification and to promote its widespread deployment. This enhances the functionality and interoperability inside the Astronomical Community.";
MyDocType[2]["other"] = '';

<!-- Status 1st part -->
MyDocType[3] = new Array();
MyDocType[3]['app'] = 'Applications Interest Group';
MyDocType[3]['dal'] = 'Data Access Layer Working Group';
MyDocType[3]['dm'] = 'Data Model Working Group';
MyDocType[3]['gws'] = 'Grid and Web Services Working Group';
MyDocType[3]['reg'] = 'Resource Registry Working Group';
MyDocType[3]['std'] = 'Standard and Document Process Working Group';
MyDocType[3]['semantics'] = 'Semantics Working Group';
MyDocType[3]['the'] = 'Theory Interest Group';
MyDocType[3]['voe'] = 'VO Event Working Group';
MyDocType[3]['vot'] = 'VO Table Working Group';
MyDocType[3]['voq'] = 'VO Query Language Working Group';
MyDocType[3]['dcp'] = 'Data Curation and Preservation IG Group';
<!-- Twiki -->
MyDocType[4] = new Array();
MyDocType[4]["app"] = "IvoaApplications";
MyDocType[4]["dal"] = "IvoaDAL";
MyDocType[4]["dm"] = "IvoaDataModel";
MyDocType[4]["gws"] = "IvoaGridAndWebServices";
MyDocType[4]["reg"] = "IvoaResReg";
MyDocType[4]["std"] = "IvoaStdsDocsProc";
MyDocType[4]["semantics"] = "IvoaSemantics";
MyDocType[4]["the"] = "IvoaTheory";
MyDocType[4]["voe"] = "IvoaVOEvent";
MyDocType[4]["vot"] = "IvoaVOTable";
MyDocType[4]["voq"] = "IvoaVOQL";
MyDocType[4]["dcp"] = "IvoaCP";


function changeValue(objectSource,objectTarget) {
  if(document.getElementById(objectSource).value=='') {
	return 1 ;
  }

  if(document.getElementById('doctypeSource').value!='' && document.getElementById('groupSource').value!='' && document.getElementById('conciseName').value != '') {
    var day = document.getElementById('daySource').value;
    var month    = document.getElementById('monthSource').value;
    var year        = document.getElementById('yearSource').value;
    var filebase = document.getElementById('conciseName').value;
    var url = MyDocType[1][document.getElementById('doctypeSource').value]+'-'+filebase+'-'+document.getElementById('version1Source').value+'.'+document.getElementById('version2Source').value+'-'+year+month+day+'.html';
    document.getElementById('fileNameIndication').innerHTML = url;
    document.getElementById('URLTarget').innerHTML = '<b>http://www.ivoa.net/Documents/'+MyDocType[1][document.getElementById('doctypeSource').value]+'/'+MyDocType[1][document.getElementById('groupSource').value]+'/'+url+'</b>';
  }
  
  <!-- Update the date in the preview -->
  var monthNames=new Array("January","February","March","April","May","June","July","August", "September","October","November","December")
  var dateStr = document.getElementById('daySource').value + " " + monthNames[document.getElementById('monthSource').value-1] + " " + document.getElementById('yearSource').value;
  document.getElementById('docDateTarget').innerHTML = dateStr;

  if (objectSource == "doctypeSource") {
    document.getElementById(objectTarget).innerHTML = MyDocType[0][document.getElementById(objectSource).value];
    document.getElementById('statusTarget').innerHTML =  MyDocType[2][document.getElementById(objectSource).value];
  } else if(objectSource == "groupSource" && (document.getElementById('groupSource').value!='none' && document.getElementById('groupSource').value!='')) {
    document.getElementById(objectTarget).innerHTML = '<a href="http://www.ivoa.net/twiki/bin/view/IVOA/'+ MyDocType[4][document.getElementById(objectSource).value] + '" target="_blank">http://www.ivoa.net/twiki/bin/view/IVOA/<span class="Input">' + MyDocType[4][document.getElementById(objectSource).value] + '</span></a>';
    document.getElementById('statusTarget').innerHTML =  MyDocType[2][document.getElementById('doctypeSource').value];
  }  else if(objectTarget != 'URLTarget'){
    document.getElementById(objectTarget).innerHTML = document.getElementById(objectSource).value;
  }
  
  if(document.getElementById('doctypeSource').value == 'rec') {
     document.getElementById('statusTarget').innerHTML =  'This document has been produced by '+ MyDocType[3][document.getElementById('groupSource').value] +'.'+ MyDocType[2][document.getElementById('doctypeSource').value];
  }

  return 0;

}

function basename (path) {
  var path = path.replace( /(.*\/)|(.*\\)/, "" );  
  pattern = /(.*)\..*/;
  var basename = path.match(pattern);
  return basename[1];
}

function extname (path) {
  var path = path.replace( /(.*\/)|(.*\\)/, "" );  
  pattern = /.*(\..*)/;
  var ext = path.match(pattern);
  return ext[1];
}

var answer;

function copyValue() {
  answer = changeValue('doctitleSource','doctitleTarget');
  answer += changeValue('version1Source','version1Target');
  changeValue('version2Source','version2Target');
  changeValue('doctypeSource','doctypeTarget');
  answer += changeValue('authorSource','authorTarget');
  answer += changeValue('editorSource','editorTarget');
  answer += changeValue('groupSource','groupTarget');
  answer += changeValue('abstractSource','abstractTarget');
  changeValue('fileSource','URLTarget');

  if (answer != 0) {
	resetPreview();
  }
}


function resetPreview() {
  document.getElementById('doctitleTarget').innerHTML = "<b><i><font color=\"red\">?</font></i></b>";
  document.getElementById('version1Target').innerHTML = "<b><i><font color=\"red\">?</font></i></b>";
  document.getElementById('version2Target').innerHTML = "0";
  document.getElementById('doctypeTarget').innerHTML = "IVOA Working Draft";
  document.getElementById('docDateTarget').innerHTML = "<i><font color=\"red\">?</font></i>";
  document.getElementById('authorTarget').innerHTML = "<i><font color=\"red\">?</font></i>";
  document.getElementById('editorTarget').innerHTML = "<i><font color=\"red\">?</font></i>";
  document.getElementById('groupTarget').innerHTML = "<a href=\"http://www.ivoa.net/twiki/bin/view/IVOA/\">http://www.ivoa.net/twiki/bin/view/IVOA/<span class=\"Input\"><font color=\"red\">?</font></span></a>";
  document.getElementById('abstractTarget').innerHTML = "<b><i><font color=\"red\">?</font></i></b>";
  document.getElementById('URLTarget').innerHTML = "<b><i><font color=\"red\">?</font></i></b>";

}
