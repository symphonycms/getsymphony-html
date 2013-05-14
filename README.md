# Symphony Community Site

## HTML Templates

This markup library contains the XML, XSLT and HTML used to build the templates for the Symphony community site. It is being maintained as a [Git repository on GitHub](https://github.com/bauhouse/getsymphony-html).

### Preprocessing HTML

XSLT is being used as a preprocessor (using xsltproc) to output valid, well-formed XHTML structure. This process of static site generation should be easy to manage on any Unix-based system (Mac, Linux) without having to install any software. On Windows, install xsltproc.

To process HTML, run the `./build` script in the same directory as this README file.

To process individual files, open the `workspace/build` file and find the xsltproc command referring to the HTML file you would like to process and run the command.

### Design Templates

The page layouts can be viewed in a browser at the following URLs: 

* http://docs.getsymphony.com/
* http://docs.getsymphony.com/docs/
* http://docs.getsymphony.com/guides/
* http://docs.getsymphony.com/tutorials/
* http://docs.getsymphony.com/articles/
* http://docs.getsymphony.com/concepts/
* http://docs.getsymphony.com/faq/
* http://docs.getsymphony.com/api/
