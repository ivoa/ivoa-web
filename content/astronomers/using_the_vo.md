---
title: "Using the VO"
draft: false
tags:
- astronomers
---

## Using the VO

Using the VO is really just a question of getting stuck in with tools and data services which understand VO rules.
Try the examples in [Getting Started](/astronomers/getting_started) and look at the list of [VO tools and portals](/astronomers/applications).
However, it can help if you have some of the key concepts in mind.

**Data Services**

The VO can be seen as a kind of club of **data services** that all follow the same rules.
Tools and web portals that understand these rules can fetch data from these services and know what to do with the data when they get it.
Of course many datasets have been available online for some time, but the advantage of standardised services is that you don't have to go to lots of different web pages and learn a different interface for each one.
You can use your favourite tool or portal, which can get at hundreds of datasets, knowing that the dialogue and parameter boxes will always be pretty much the same.
For example, a **cone search service** always asks for an RA, Dec, and radius, and returns a table of objects.
The tool you are using will know when something is a cone-search service and so will pop up the right dialogue.

**Registries: the VO Yellow Pages**

How do you find the data service you want? This is made possible by the fact that any data service following standard rules will be **registered** by its creators in one of several Registries round the world.
(They periodically update themselves by checking out other registries).
The registry entry will have descriptive **metadata** - what kind of service is it?
What is the URL you need to get at it?
What parameters do you need to put in to a request?
What kind of data comes back? and so on.
In principle, a human being could look at these metadata entries, but really they are there for the tools, so that they know how to deal with a given data service.
For example, consider the VOSpec tool, which specialises in Spectral Access services.
You can put a keyword into the "target" box and click "query", which will cause VOSpec to search the registry for spectral services that match that keyword.
When you pick one of these services, you will find that some have extra input parameters, but VOSpec knows this because this information is in the registry.

It is helpful to bear in mind the distinction between querying the registry, and querying the actual data services.
The first step is like looking for plumbers in Yellow Pages.
The second step is the equivalent of actually phoning a plumber after you have picked one.
Of course you might keep the phone number of your favourite plumber handy and go straight to that step.
Likewise, some tools build in fixed connections to popular services, as well as providing a registry search facility.
Some tools, like Datascope or VO Desktop, actually specialise in searching the registry, and bookmarking favourite resources, and then hand over the analysis of the data to a different tool.

**Standard data formats**

VO services are expected to return standard data formats, so that tools can make sensible use of the data.
Generally this either means industry standard formats such as JPG, or well known astronomical formats such as FITS.
However, you will also come across a specialised VO format for tables of information, known as VOTable.
All VO tools know how to deal with VO Tables, so you don't need to understand the structure, but the main advantage is that VOTable has more flexible descriptive metadata than for example CSV files or FITS tables.

Another VO improvement for data tables is that any table column has an associated "Universal Content Descriptor" or UCD, which tells software using the table what kind of quantity is in that column.
For example, if the name of a table column is "alpha" it would be unclear what it is, but if its UCD is given as "pos.eq.RA" then the software will knows that it is a Right Ascension.

**Passing data between applications**

The VO aims at making it easy to access data over the internet, but it also aims at making tools in the VO club inter-operate with each other.
For example, imagine you have used Aladin or DS9 to get an image cut out from SDSS data, and then separately have used Topcat to do a cone-search for FIRST radio sources in the same region.
You can then ask Topcat to "broadcast" the FIRST data table, and it will be overplotted on your SDSS image.
This works using a "messaging hub" system known as SAMP.

**Types of data service**

Here is a brief summary of some of the main kinds of data service which have so far been standardised by the IVOA.

**Cone search** services offer the simplest access to astronomical catalogues.
The input is sky-position and radius. The return is a subset of the catalogue within that radius.

**Table Access Protocol (TAP)** services offer more flexible access to data tables, along the lines astronomers have become used to in making queries to databases like those of SDSS or UKIDSS.
The input is a query in Astronomical Data Query Language (ADQL), which is basically a standardised version of SQL.
The return is a data table. You don't necessarily have to learn ADQL, if for example the tool you are using can show you a list of the columns for that database, and give you an interactive way of building a query.

**Simple Image Access Protocol (SIAP)** services offer access to pixel data.
The input is a position and a size.
If the SIAP service is a "cut-out" service, the return will be an image centred at the requested position, with the requested size.
If it is an "Atlas" service, which holds a collection of standard sized data frames, then the size is used to look for frames centred within that distance of the requested position, and the whole data frame(s) returned.

**Simple Spectral Access Protocol (SSAP)** services provide access to spectra.
The input is a position and size. Like the "atlas" version of image access, the return will be any spectra whose target positions are within the stated distance of the requested position.

The "simple" part of the image and spectral access protocols refer to the fact that the search is only by position.
Newer versions of the protocols are under development which will allow more flexible searching.

**Registry Searching** As discussed above, services put all sorts of useful information in their registry entries, and some tools make use of this.
So for example, you can look specifically for image services, for X-ray data, for data curated by HEASARC, for services that are new this month, and so on.

**Single Sign-on**

So far, VO tools and services have concentrated on fully public data services, but of course every day astronomers are using data to which they have private access - because they have PI time on a space mission, or because they are a member of a consortium that owns the data.
The usual practice is enter a username and password at the relevant website. The IVOA is discussing how to standardise expressing identity, so that secure data services can be included in the VO, and you only need to "sign on" once. Watch this space.

**Application Services**

As well as data services, it would be useful to able to run applications remotely in a standardised way - for example, uploading your own image to a catalogue extraction service, or running a theoretical calculation.
Some VO projects have already set up tools of this kind. The IVOA is discussing how to standardise this kind of service so that it should become as easy as accessing data.