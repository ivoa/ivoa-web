---
title: "Getting Started"
date: 
draft: false
tags:
- about
---

# Getting Started
---------------

Here are three simple blow-by-blow examples of using VO tools and services : [browsing images](#browse-all-sky-images), [searching catalogs](#getting-a-ukidss-catalogue-with-topcat), and [finding available data for an object](#find-all-data-at-a-given-position).

## Browse all sky images**

{{< floating right >}}
[![aladin!](/images/astronomers/getting_started/aladin_thumb.png)](/images/astronomers/getting_started/aladin.png)
{{</ floating >}}
Several image analysis tools, such as DS9, Aladin, and Gaia, can browse VO image services, as well as loading local files. As an example, try Aladin.

1.  If you don't already have it, [download](http://aladin.u-strasbg.fr) it and start it up.  
      
    
2.  Type "3c 227" into the box at the top and press return. That text string is sent to the Simbad name resolver which returns the RA/Dec of 3c 227 and you get a DSS image of the region surrounding 3c227. You can zoom in and out, and pan over the whole sky.  
      
    
3.  Next, from the row below, click on "2MASS". This overlays objects from the 2MASS catalog. If you click on one of these, you get information from the 2MASS catalog. Leave this displayed while you try the next example.  
      
    

* * *
## Getting a UKIDSS catalogue with Topcat

Topcat is a tool for fetching, manipulating, and plotting tables of data. If you don't have it already, [download](http://www.star.bris.ac.uk/~mbt/topcat) it and start it up.

1.  Go to the "VO" menu and choose "cone search". Around the world, thousands of different datasets are set up as cone search services, and listed in registries of VO services. Topcat can find the one you want and then search it. {{< floating right >}}[![](/images/astronomers/getting_started/topcat-aladin-thumb.png)](/images/astronomers/getting_started/topcat-aladin.png){{</ floating >}}  
      
    
2.  In "keywords" type "UKIDSS" and then click "submit query". Topcat returns a longish list of conesearch services with a UKIDSS connection.  
      
    
3.  Scroll down to UKIDSS DR4 and click on that. The window below lists several different tables available within UKIDSS DR4.  
      
    
4.  Lets say we want the Large Area Survey. Scroll down to "lasSource" and highlight that.  
      
    
5.  Now go down to "Object Name", type in "3c 227", and click "Resolve" to get the RA/Dec. In "radius" put 3 arcminutes, and then click "OK". Topcat now searches the UKIDSS LAS database at that position, and returns a table with 175 objects in it. You can now examine, analyse, and plot this table.  
      
    
6.  Finally, spot the "transmit" icon in Topcat's top row. VO compatible tools, like Aladin and Topcat, can swap messages between each other. Highlight the 3c 227 table you just made and click the transmit icon. The table now appears as an overlay in Aladin, so you can compare the UKIDSS and 2MASS sources. If you explore more in Aladin, you can get the UKIDSS images too.

* * *

## Find all data at a given position

{{< floating right >}}![ddt](/images/astronomers/getting_started/data_discovery_tool.png){{</ floating >}} Suppose you want more data on 3c227 but don't know exactly what you want ? The US VAO project provides a tool called the Data Discovery Tool to do this. Its part of a [web portal](http://www.usvao.org) that can do a variety of things.

1.  Go to the [portal](http://www.usvao.org), navigate to the **Data Discovery Tool** and click "Launch".  
      
    
2.  In the box at the top, type "3c 227", use a radius of 3 arcmin, and click search. The tool sends a message to every known service asking whether it has any data within 3 arcmin of that position, and returns a table with an entry for every resource that responds.  
      
    
3.  This can be quite a long list, but you can narrow it down with the filters on the left. Check the boxes for "Images" and "optical". You will now have a much shorter list.  
      
    
4.  Highlight the row that says "SDSSDR5". The pop-up box tells you more information about that resource.  
      
    
5.  Click the "Continue to Data" button at top left. You now get a new tab with a table where each entry is an image file. Click one of these, and you get another pop-up box. Click "Broadcast (SAMP)" and the SDSS image will appear in Aladin.  
      
    
6.  Now go back to the first tab, uncheck "Images" and check "Catalog". Highlight the SDSS DR5 catalog and click load. The catalog appears in a new tab. You can explore this within the tool, sorting by various columns etc, or you can click "Export Table As..." and then click "Broadcast". The table will now appear both in Topcat, and in Aladin, overlaid on your SDSS image.

* * *

  
**Going Further**

To learn a little more, its mostly a matter of explaining the tools and portals, but you can get more explanation and links in "[Using the VO](using_the_vo.html)" and "[Tools and portal](applications.html)s" worldwide.

