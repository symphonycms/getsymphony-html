# Symphony Community Site - Workspace

For the Symphony Community Site project, the first step we are taking is to deliver HTML, CSS and JavaScript for integration into Symphony. We have created a static site generator as a means of quickly prototyping web page layouts as static HTML files, while still being able to maintain all the features of the layout that we intended to deliver for the project, such as current classes on selected navigation items.

We are using the same basic directory structure as the Symphony `workspace` in order to make the work of integration as seamless as possible. The best way to deliver quality code for the project is to rely on XSLT, the W3C standard for templating. Rather than have to manually edit pages across the entire set of layouts, we run a series of commands on the command line to generate the pages for the site. Because these commands rely on `xsltproc`, which is already available out of the box in any UNIX-based system, including Mac and Linux, it is a great way to use XML and XSLT in the front end development process even before setting up the Symphony install.

#### Directory Structure

The main difference between the directory structure of the [Symphony workspace](https://github.com/symphonycms/workspace) and the XSLT static site generator is the addition of the `data` directory, which contains XML data used by all pages. Also, for static site generation, there is no need for any of the PHP files used by the system, so the only other directories needed are the `pages` and `utilities` directories.

	site/
	├── workspace/
	│   ├── data/
	|   |   ├── index.xml
	│   ├── pages/
	│   │   ├── index.xsl
	│   ├── utilities/
	│   │   ├── master.xsl

#### XML Data

When creating HTML output with XSLT, you always need to start with XML data. Extensible Stylesheet Language Templates are an extension of XML, Extensible Markup Language. With XSLT, you can output to any text-based format that you like, but it shines in its ability to transform any form of valid XML data into other forms of XML, such as XHTML.

You don't need much data to transform into output. You could start with something as simple as a single node.

#### data.xml

    <?xml version="1.0" encoding="utf-8" ?>
    <data/>

Then, use the simplest XSLT stylesheet.

#### hello.xsl

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="text"/>
      <xsl:template match="/">Hello</xsl:template>
    </xsl:stylesheet>

Run the following command in the same directory as these files and the output would be a simple text file with the word, `Hello`:

    xsltproc -v -o hello.txt hello.xsl data.xml

#### hello.txt

    Hello

### Static Site Generation Files

For the purposes of what we needed to accomplish, we only needed a small set of data to set specific properties.

#### index.xml

I create an XML file that will serve as the data source for page-specific parameters, such as page title, the URL handle for the current page, and how to navigate to the root directory relative to the current directory.

    <?xml version="1.0" encoding="utf-8" ?>
    <?xml-stylesheet type="text/xsl" href="workspace/pages/index.xsl" ?>
    <!-- xsltproc -v -o index.html workspace/pages/index.xsl index.xml -->
    <data>
      <params>
        <website-name>Site Name</website-name>
        <page-title>Home</page-title>
        <current-page>home</current-page>
        <root>.</root>
      </params>
    </data>

The file also includes the `xml-stylesheet` declaration that enables a browser to process HTML with the specified XSL file when pointing to the XML file.

And, just in case you want to run the `xsltproc` command from within the same directory as the `index.html` file, there is a comment to store the command.

#### index.xsl

The XML file is transformed into HTML by XSLT stylesheets stored in the `workspace/pages` directory.

A page template can start out very basic:

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="../utilities/master.xsl" />
    
    <xsl:template match="data">
      <h2><xsl:value-of select="params/page-title" /></h2>
    </xsl:template>
    
    </xsl:stylesheet>

There's not much going on in this template other than an `xsl:import` instruction and a match template to output an an `h2` element with the page title. The intention is that the page template will contain only page-specific content.

The important thing to note in this file is that the match template is using an XPath expression as the value of the `match` attribute. This template matches the `data` node of the XML file. As the processor is navigating the XML tree, when it finds the data node, the XSLT creates output by following the instructions found in the `xsl:template` element.

While the `data` node is the first node of the XML document, the root of the document precedes the first node. The root of the document is selected by the match template with a forward slash (`/`) as the value of the match attribute. We find this value in the imported `master.xsl` stylesheet.

#### master.xsl

The `index.xsl` page template imports the `master.xsl` stylesheet from the `workspace/utilities` directory.

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml"
      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
      omit-xml-declaration="yes"
      encoding="UTF-8"
      indent="yes" />
    
    <xsl:template match="/">
      <html>
        <head>
          <title><xsl:value-of select="data/params/website-name" /></title>
        </head>
        <body>
          <h1><xsl:value-of select="data/params/website-name" /></h1>
          <xsl:apply-templates />
        </body>
      </html>
    </xsl:template>
    
    </xsl:stylesheet>

The master template is being used to manage the structure of the page outside of the main content area.

#### HTML Output

If you view the XML file in a modern browser, you'll see the generated HTML. If you view the source, you'll probably see the original XML file. You can view the rendered source with browser developer tools.

To actually render the HTML file and save the file to the directory, run this command inside the directory containing the `index.xml` file:

    xsltproc -v -o index.html workspace/pages/index.xsl index.xml

The command will use the XSLT processor to process the `index.xml` file with the `workspace/pages/index.xsl` file and output to the `index.html` file. This is the command that is documented at the top of the XML file.

#### index.html

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Site Name</title>
      </head>
      <body>
        <h1>Site Name</h1>
        <h2>Home</h2>
      </body>
    </html>

Now, the directory structure should look like this:

    site/
    ├── index.html
    ├── workspace/
    │   ├── data/
    │   │   ├── index.xml
    │   ├── pages/
    │   │   ├── index.xsl
    │   ├── utilities/
    │   │   ├── master.xsl

The `index.html` file was created by the XSLT processor. At this point, we don't have more than a single page, so we haven't considered data that is needed by all pages, so I haven't included the `data` directory yet.

#### The Build File

We can set up a simple shell script that allows the ability to run the XSLT processing command with a simple command.

Create a file called `build` in the `workspace` directory with the following contents:

    #!/bin/bash
    
    xsltproc -v -o ../index.html pages/index.xsl index.xml;

We have added a semicolon to the end of the command so we can run multiple commands when we eventually add more pages to the list.

Make sure the file has the correct permissions to be able to execute the script:

    chmod 755 build

Then, simply call the shell script from the root directory.

    ./build

That's the basic example. The actual templates are a little more complex. Let's see if we can break it down into understandable pieces.

### XSLT Templates

What makes XSLT really interesting is the ability to set variables and parameters, and the ability to set modes on templates and override templates. All of these things help to keep the process of building pages DRY (Don't Repeat Yourself). So, let's start by breaking down the page into manageable pieces, so we need only edit each part in one place.

#### master.xsl

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fb="http://ogp.me/ns/fb#">
    
    <xsl:import href="../utilities/head.xsl" />
    <xsl:import href="../utilities/body.xsl" />
    
    <xsl:output method="xml"
      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
      omit-xml-declaration="yes"
      encoding="UTF-8"
      indent="yes" />
    
    <!-- Page Parameters -->
    <xsl:param name="config" select="document('../data/_config.xml')" />
    <xsl:param name="website-name" select="$config/data/config/website-name" />
    <xsl:param name="site" select="/data/params/site" />
    <xsl:param name="root" select="/data/params/root" />
    <xsl:param name="workspace" select="concat($root, '/workspace')" />
    <xsl:param name="page-title" select="/data/params/page-title" />
    <xsl:param name="current-page" select="/data/params/current-page" />
    <xsl:param name="parent-page" select="/data/params/parent-page" />
    <xsl:param name="section-page" select="/data/params/section-page" />
    <xsl:param name="subsection-page" select="/data/params/subsection-page" />
    <xsl:param name="root-page">
      <xsl:choose>
        <xsl:when test="/data/params/root-page">
          <xsl:value-of select="/data/params/root-page" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$current-page" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="network" select="document('../data/_network.xml')" />
    <xsl:param name="navigation" select="document('../data/_navigation.xml')" />
    <xsl:param name="has-section-nav" select="false()" />
    
    <!-- Directories -->
    <xsl:param name="assets" select="concat($workspace, '/assets')" />
    <xsl:param name="css" select="concat($assets, '/css')" />
    <xsl:param name="scripts" select="concat($assets, '/js')" />
    <xsl:param name="images" select="concat($assets, '/images')" />
    <xsl:param name="theme" select="concat($workspace, '/factory')" />
    
    <xsl:template match="/">
      <xsl:comment><![CDATA[[if lt IE 7]> <html class="ie ie6 lt-ie7 no-js" lang="en" xmlns:fb="http://ogp.me/ns/fb#"> <![endif]]]></xsl:comment>
      <xsl:comment><![CDATA[[if IE 7]>    <html class="ie ie7 lt-ie8 no-js" lang="en" xmlns:fb="http://ogp.me/ns/fb#"> <![endif]]]></xsl:comment>
      <xsl:comment><![CDATA[[if IE 8]>    <html class="ie ie8 lt-ie9 no-js" lang="en" xmlns:fb="http://ogp.me/ns/fb#"> <![endif]]]></xsl:comment>
      <xsl:comment><![CDATA[[if IE 9]>    <html class="ie ie9 lt-ie10 no-js" lang="en" xmlns:fb="http://ogp.me/ns/fb#"> <![endif]]]></xsl:comment>
      <xsl:comment><![CDATA[[if gt IE 9]><!]]></xsl:comment><html class="no-js" lang="en" xmlns:fb="http://ogp.me/ns/fb#"><xsl:comment><![CDATA[<![endif]]]></xsl:comment>
        <xsl:apply-templates select="." mode="head" />
        <xsl:apply-templates select="." mode="body" />
      </html>
    </xsl:template>
    
    </xsl:stylesheet>

The master template is a single template that acts as the central station for managing all the page layouts of the site. All the elements that are consistent across the site design should be accounted for with this template, at least as a reference to other templates.

The `xsl:stylesheet` element declares the XML namespace for the Facebook Open Graph Protocol. For the XSLT processor to run without errors, the XML namespaces used in the document must be properly declared.

    xmlns:fb="http://ogp.me/ns/fb#"

The `xsl:import` instructions include `href` attributes with values that point to the templates on which the master template depends. The child elements for any HTML document are the `head` and `body` elements. So, we create a separate template to be responsible for each element and its descendant elements and import these templates into the master template.

- `head.xsl` 
- `body.xsl`

The `xsl:output` element sets the properties to be used to render the output of the XSL transformation.

- Format: XML
- Doctype: XHTML 1.0 Strict
- Document Type Declaration Schema URL: http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd
- Omit the XML declaration: yes
- Character encoding: UTF-8
- Code Indenting: yes

In this case, the template collects data from the XML file in the form of page parameters

- `$config`
- `$website-name`
- `$root`
- `$workspace`
- `$assets`
- `$page-title`
- `$current-page`
- `$parent-page`
- `$section-page`
- `$subsection-page`
- `$root-page`
- `$navigation`
- `$has-section-nav`

There is also a set of parameters to render the paths to directories storing the site design assets:

- `$css`
- `$scripts`
- `$images`
- `$theme`

These paths will be output as relative URLs, with the `$root` rendered as a relative path.

Finally, we come to the match template, which matches the root of the XML document. This is where the transformation begins. We would usually start with the root element of the HTML document, the `html` element. However, because we want to serve IE conditional comments, the template starts with `xsl:comment` instructions to render `CDATA` sections needed to render properly formatted HTML comments. The XSLT processor will ignore comments when processing the output, so comments must use the `xsl:comment` instruction to render the output.

Within the conditional comment for the latest version of IE is the opening tag of the `html` element. Contained within the `html` element are two `xsl:apply-templates` instructions with `.` as the value of the `select` attribute with different values for the `mode` attribute. The dot is an XPath expression referring to the current node. This means that the XSLT processor will continue from this point by first finding templates with the same mode value that match the current node, that is, the root node (`/`).

We'll describe these two XSLT stylesheets next.

#### head.xsl

The `head` element contains the `meta`, `title`, `link` and `script` elements.

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="../utilities/js.xsl" />
    
    <xsl:template match="/" mode="head">
      <head>
        <meta name="description" content="{$website-name}" />
        <meta name="author" content="{$website-name}" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <xsl:apply-templates mode="page-title" />
        <xsl:apply-templates mode="css" />
        <xsl:apply-templates mode="js" />
      </head>
    </xsl:template>
    
    <xsl:template match="data" mode="page-title">
      <title>
        <xsl:value-of select="$page-title" />
        <xsl:text> | </xsl:text>
        <xsl:value-of select="$website-name"/>
      </title>
    </xsl:template>
    
    <xsl:template match="data" mode="css">
    	<link rel="stylesheet" href="{$css}screen.css" />
      <xsl:comment><![CDATA[[if IE]> <link href="]]><xsl:value-of select="$css" /><![CDATA[ie.css" media="screen, projection" rel="stylesheet" type="text/css" /> <![endif]]]></xsl:comment>
    </xsl:template>
    
    </xsl:stylesheet>

At the top of the file, the `xsl:import` instruction refers to the `js.xsl` stylesheet, containing instructions for handling the `script` elements for JavaScript files.

This XSLT stylesheet contains three templates. The first template is the match template with a `mode` attribute value of `head` that matches the root element (`/`). This is the next step for the XSLT processor after processing the `master.xsl` stylesheet.

Using the mode allows the ability to use the `xsl:apply-templates` instruction without needing to traverse further down the XML tree structure before adding more structure and processing additional instructions to render the desired output.

The three `xsl:apply-templates` instructions inside the `head` match template do not have `select` attributes. These templates will be processed on matching the next node in the XML tree structure, which is the `data` node. These templates have been set to output the `title`, `link` and `script` elements, using the `page-title`, `css` and `js` modes, respectively.

The second template is the match template with a mode of `page-title`. This template matches the `data` node of the XML. The parameters `$page-title` and `$website-name` that were declared in the `master.xsl` template are output by the `xsl:value-of` instructions.

#### body.xsl

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="../utilities/network.xsl" />
    <xsl:import href="../utilities/header.xsl" />
    <xsl:import href="../utilities/footer.xsl" />
    
    <xsl:template match="/" mode="body">
      <body>
        <!-- Symphony Network -->
        <xsl:call-template name="network" />
        <!-- Current page -->
        <div id="site">
          <xsl:call-template name="header" />
          <xsl:apply-templates />
        </div>
        <xsl:call-template name="footer" />
      </body>
    </xsl:template>
    
    </xsl:stylesheet>

The `xsl:call-template` instructions refer to the named templates contained by the stylesheets imported at the beginning of the `body.xsl` stylesheet. These stylesheets contain templates to manage the following pieces of the page layout:

- network navigation
- header
- footer

In the middle of these `xsl:call-template` instructions is another `xsl:apply-templates` instruction that has no `select` or `mode` attributes. The XSLT processor will continue traversing the XML document, matching elements to templates to process the remaining instructions. Here is where the main content area of the page is built.

#### index.xsl

The home page uses the `master.xsl` template and processes the `content` node of the page with the "Ninja Technique", which is what the Symphony community calls what is more commonly referred to as an [identity transform](http://en.wikipedia.org/wiki/Identity_transform).

    <?xml version="1.0" encoding="utf-8" ?>
    <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="../utilities/master.xsl" />
    <xsl:import href="../utilities/ninja.xsl" />
    
    <xsl:template match="data">
    	<xsl:apply-templates select="content/*" mode="ninja" />
    </xsl:template>
    
    </xsl:stylesheet>

Each HTML page is built by processing many different templates that can be modified in one place. By building each page on these same templates, changes can be reflected across the entire set of HTML pages by running a `build` script that maintains a record of all the `xsltproc` commands to process each HTML file.

The file structure currently looks something like this, although we have modified the page structure to be more generic, simpler and not quite as deeply nested:

    site/
    ├── about/
    │   ├── index.html
    ├── blog/
    │   ├── index.html
    ├── discussions/
    │   ├── index.html
    │   ├── post/
    │   │   ├── index.html
    ├── events/
    │   ├── index.html
    ├── index.html
    ├── questions/
    │   ├── index.html
    ├── README.md
    ├── showcase/
    │   ├── index.html
    ├── workspace/
    │   ├── assets/
    │   │   ├── themes/
    │   │   │   ├── factory/
    │   │   │   │   ├── css/
    │   │   │   │   ├── docs/
    │   │   │   │   ├── img/
    │   │   │   │   ├── index.htm
    │   │   │   │   ├── js/
    │   │   │   │   ├── license.md
    │   │   │   │   ├── README.md
    │   │   │   │   ├── xsl/
    │   ├── data/
    │   │   ├── _config.xml
    │   │   ├── _navigation.xml
    │   │   ├── _pages.xml
    │   │   ├── about.xml
    │   │   ├── blog.xml
    │   │   ├── discussions_post.xml
    │   │   ├── discussions.xml
    │   │   ├── events.xml
    │   │   ├── index.xml
    │   │   ├── questions.xml
    │   │   ├── showcase.xml
    │   ├── pages/
    │   │   ├── about.xsl
    │   │   ├── blog.xsl
    │   │   ├── discussions_post.xsl
    │   │   ├── discussions.xsl
    │   │   ├── events.xsl
    │   │   ├── index.xsl
    │   │   ├── questions.xsl
    │   │   ├── showcase.xsl
    │   ├── README.md
    │   ├── utilities/
    │   │   ├── body.xsl
    │   │   ├── build.xsl
    │   │   ├── footer.xsl
    │   │   ├── head.xsl
    │   │   ├── header.xsl
    │   │   ├── js.xsl
    │   │   ├── master.xsl
    │   │   ├── network.xsl
    │   │   ├── ninja.xsl
    │   │   ├── page-title.xsl
    │   │   ├── pagination.xsl
    │   │   ├── readme.xsl

#### Adding Pages

The pages of the site are created by adding two files for each page, which correspond to the data (XML) and the template (XSLT) required to process each page as HTML. These files are mapped to an output by defining them in the `_pages.xml` file.

#### _pages.xml

    <?xml version="1.0" encoding="utf-8" ?>
    <data>
      <pages>
        <page output="index.html" xslt="pages/index.xsl" data-source="data/index.xml">
          <title>Home</title>
        </page>
        <page output="discussions/index.html" xslt="pages/discussions.xsl" data-source="data/discussions.xml">
          <title>Discussions</title>
        </page>
        <page output="discussions/post/index.html" xslt="pages/discussions_post.xsl" data-source="data/discussions_post.xml">
          <title>Discussion</title>
        </page>
        <page output="questions/index.html" xslt="pages/questions.xsl" data-source="data/questions.xml">
          <title>Questions</title>
        </page>
        <page output="blog/index.html" xslt="pages/blog.xsl" data-source="data/blog.xml">
          <title>Blog</title>
        </page>
        <page output="showcase/index.html" xslt="pages/showcase.xsl" data-source="data/showcase.xml">
          <title>Showcase</title>
        </page>
        <page output="events/index.html" xslt="pages/events.xsl" data-source="data/events.xml">
          <title>Events</title>
        </page>
        <page output="about/index.html" xslt="pages/about.xsl" data-source="data/about.xml">
          <title>About</title>
        </page>
      </pages>
    </data>

#### _navigation.xml

Another file acts as a data source to create the site navigation: `_navigation.xml`.

    <?xml version="1.0" encoding="utf-8" ?>
    <data>
      <navigation>
        <page handle="stream" type="index">
          <name>Stream</name>
        </page>
        <page handle="discussions">
          <name>Discussions</name>
          <page handle="post">
            <name>Discussion</name>
          </page>
        </page>
        <page handle="questions">
          <name>Questions</name>
        </page>
        <page handle="blog">
          <name>Blog</name>
        </page>
        <page handle="showcase">
          <name>Showcase</name>
        </page>
        <page handle="events">
          <name>Events</name>
        </page>
        <page handle="about">
          <name>About</name>
        </page>
      </navigation>
    </data>

#### Output HTML Files

To output HTML files, open Terminal and navigate to the `workspace` directory of the site repository.

  cd /path/to/site/workspace

From here, you can process XML files with XSLT to output HTML files by using xsltproc on the command line. This command would output the `index.html` file.

  xsltproc -v -o ../index.html pages/index.xsl data/index.xml;

So, you could run this command for each file, but it's also possible to automatically generate a shell script with XSLT that could be used to build the entire tree structure of the site. Then, all you would need to do is run the script on the command line:

    ./build

#### The Build File

The `workspace/build` file is automatically generated from the `_pages.xml` file using the `workspace/build.xsl` file. So, the `build` script actually builds itself first:

    xsltproc -v -o build utilities/build.xsl data/_pages.xml;

Then, it runs the xsltproc command to create the `README.md` file as well, automatically generated from the `_pages.xml` file by the `workspace/utilities/readme.xsl` file.

    xsltproc -v -o ../README.md utilities/readme.xsl data/_pages.xml;

As more pages are added to the site, the xsltproc commands for processing each XML file to output the HTML are added to the `build` script. With the site structure described above, the `build` file would look something more like this:

    #!/bin/bash
    
    # Generate the build script
    
    xsltproc -v -o build utilities/build.xsl data/_pages.xml;
    
    # Create the README file
    
    xsltproc -v -o ../README.md utilities/readme.xsl data/_pages.xml;
    
    # These commands will process HTML files with XSLT when you run `./build` inside the `workspace` directory.
    # This list is dynamically generated as you add more pages to the `data/_pages.xml` file.
    
    xsltproc -v -o ../index.html pages/index.xsl data/index.xml;
    xsltproc -v -o ../discussions/index.html pages/discussions.xsl data/discussions.xml;
    xsltproc -v -o ../discussions/post/index.html pages/discussions_post.xsl data/discussions_post.xml;
    xsltproc -v -o ../questions/index.html pages/questions.xsl data/questions.xml;
    xsltproc -v -o ../blog/index.html pages/blog.xsl data/blog.xml;
    xsltproc -v -o ../showcase/index.html pages/showcase.xsl data/showcase.xml;
    xsltproc -v -o ../events/index.html pages/events.xsl data/events.xml;
    xsltproc -v -o ../about/index.html pages/about.xsl data/about.xml;

Again, it requires just a simple command to process all HTML files:

    ./build

#### XSLT Static Site Generator

So, there you have it: a static site generator using XSLT to output the HTML files and directory structure to be able to deploy your site to any server that can serve plain old HTML files.

#### Page Layouts and Content

Next, we can start building out some layouts for the different content types that we will need to incorporate into the site. Also, we can delve a little deeper into how the templates work.