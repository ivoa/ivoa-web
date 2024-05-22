---
title: "VO Glossary for Astronomers"
tags:
- astronomers
--- 

Here is a very brief explanation of some of the terms you may come across in the VO world. It's aimed at astronomers. A much more technical list of terms and acronyms is maintained [here](http://wiki.ivoa.net/twiki/bin/view/IVOA/VOGlossary). Note that we don't list popular tools here - you can find a list of those on the [VO Software](../applications/) page.

**ADQL**
: Astronomy Data Query Language. A standard language for querying astronomy databases, based on SQL (Standard Query Language). Standardisation was necessary because the popular commercial and open source variants of SQL all differ slightly, and IVOA wanted a standard way of specifying a region, which SQL does not provide.

**Capability**
: What a service can do for you - i.e. whether it offers a cone search service, or a TAP service, or a plain web interface, etc. A service can offer more than one capability.

**Cone Search**
: A simple data service allowing retrieval of catalogue information on objects within a given radius around a specified location. (Viewed in 3D, the radius defines a cone of space.) You get a fixed set of columns back, set by the data service in question.

**Crossmatch**
: The process of finding records in one data collection that match those in another - for example which object(s) in an optical catalogue are the ID(s) for a list of X-ray sources. Clearly this requires that the two data services are interoperable !

**Database**
: An organised data collection that comes with a system for querying the data. Most often refers to tabular datasets organised as a "relational database", i.e. a set of linked tables, that you can query using Structured Query Language (SQL). IVOA specifies a standardised version of SQL called ADQL.

**Data Model**
: A standard logical structure for a type of dataset, that makes it possible for tools to make sense of returned data. This is not the same as a data format. A data model might, for example, mandate that a dataset contains a series of records representing objects, and that each record must contain quantities representing RA, Dec, epoch of observation, and so on. A data format on the other hand specifies that the file is a table, that the entries are in ASCII, that the integers are 16 bit, and so on.

**FITS**
: Flexible Image Transport System. The standard format for astronomical images and tables. FITS also specifies a standard way of expressing metadata in keyword-value pairs, and specifies a small number of mandatory keywords, along with a slightly larger number of reserved keywords, which have to have a particular meaning if a file uses them. Every FITS table can be expressed as a VOTable, but not necessarily vice versa, as the VOTable format can contain more complicated metadata.

**IVOA**
: International Virtual Observatory Alliance. An organisation encouraging collaboration between Virtual Observatory efforts worldwide, and agreeing the standards necessary to make the VO work.

**Metadata**
: Data about data. Normally used to mean standardised descriptive information that goes with a data file (e.g. FITS keywords), or information in a registry entry that describes a resource such as a data service, or information that specifies the structure of a database - a list of its tables, their column names, and their UCDs.

**NED**
: NASA/IPAC Extragalactic Database. A very large database of astronomical objects maintained by IPAC at Caltech. Queryable via a custom web-interface and also as a single large cone-search service.

**VO Portal**
: A web page that offers a "one-stop shop" style of access to VO tools and services, as opposed to distinct and independent tools.

**Registry**
: The Yellow Pages of the VO. Any resource - usually but not always a service of some kind - will have a registry entry with standardised information that describes what it is, how you access it, and so on. There are several registries in operation, but they update from each other. User tools find services and access their data through one or more registries.

**Service**
: Something on the internet which will actively do something for you, as opposed to being a passive repository of information. For example, an image service may have a large atlas of images, but also offers a way of submitting a query to get back a cut-out image from a particular piece of sky.

**SAMP**
: Messaging protocol that allows applications to exchange messages and data between each other through a central hub, which is a tiny application that runs on the user's desktop. For example, you might have retrieved a catalogue from a cone search service using Topcat, but also have an image tool such as Aladin or DS9 running, looking at an image of the same piece of sky. Topcat can then send the table to the image tool, which can overplot the objects on the image.

**SIAP**
: Simple Image Access Protocol. SIAP services are archives that return astronomical images within a specified position and radius. Some services return a cutout of the specified size, and some a fixed-sized image from an atlas of images.

**Simbad**
: A very large VO compatible database of astronomical objects maintained at CDS in Strasbourg. It can be queried in several different ways, including both fixed pattern web forms, or completely flexibly using an ADQL query, using the VO TAP standard.

**Single Sign on**
: Many datasets in the VO are public, but many have some proprietary restrictions, that need a user to specify who they are, and for the service to work out if they are allowed access. The idea behind single sign-on is that you should only have to sign-on once per session, and have your credentials passed around as necessary. The technical infrastructure for this is agreed but not yet fully implemented.

**SSAP**
: Simple Spectral Access Protocol. SSAP services are archives that return astronomical spectra within a specified position and radius. Future more sophisticated protocols should allow selection by other parameters, such as wavelength range, or date of observation.

**SQL**
: Structured Query Language. An industry standard way of submitting queries to relational databases, made popular in astronomy by surveys such as SDSS and UKIDSS. Unfortunately, the details of SQL vary slightly between different brands of database (i.e. Oracle vs Microsoft SQL Server vs Postgres etc), and it is very awkward to search within a spatial region. The IVOA therefore agreed to an astronomically dedicated version known as Astronomical Data Query Language (ADQL).

**Synchronous/Asynchronous Services**
: A synchronous service is one where the user needs to stay connected to a remote service and interact with it in real time, whereas with an asynchronous service the user specifies a job to be done, disconnects and collects the result later. For this to work, the IVOA has agreed a standardised way of describing a job, and the current state of a job.

**VizieR**
: A very large collection of astronomical catalogues and tables stored at CDS, Strasbourg. As well as well known catalogues, it includes many tables published as part of astronomical papers. Vizier catalogues and tables can be accessed through the CDS web pages, or through several different VO tools.

**VOEvent**
: Standard format for describing an astronomical event, such as a supernova or gamma-ray burst. A VOEvent packet contains information on the location, time, and likely nature of a transient astronomical event, as well as information on its observation.

**VOSpace**
: VO-standardised remote storage. Like many other VO standards, VOSpace doesn't specify how the remote storage is organised, but only how a software tool interfaces to it, so it looks the same from a user's point of view.

**VOTable**
: Standard format for representing and exchanging tabular data within the VO. Most data archives now offer export of data in VOTable format, and a large number of tools read VOTables. Any FITS table can also be expressed as a VOTable, but not always the other way round, because VOTable can hold more structured metadata, rather than just keyword-value pairs.

**TAP**
: Table Access Protocol. TAP services provide query-driven access to astronomical tables and databases. For example, whereas a simple cone-search allows you to search only by sky position, and returns a fixed set of columns, a TAP service allows to make searches along the lines of "give me all the records with B-V>2.0 and give me just columns B, D, F, and G". Queries need to be formulated in the standard ADQL, but often the tool you are using will construct this for you.

**UCD**
: Unified Content Descriptor. A standard vocabulary for describing astronomical data quantities. It does not specify the name of a quantity, or its units, but rather what _type_ of quantity it is. For example, a column in table might have the name "T-kin" and the UCD "phys.temperature" which states that it represents a temperature, but does not imply a specific unit.

**Units**
: IVOA standardised strings to specify the units of a quantity. At the time of writing this is in the final stages of agreement by the IVOA.
