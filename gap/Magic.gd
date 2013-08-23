#############################################################################
##
##  Magic.gd                                         AutoDoc package
##
##  Copyright 2013, Max Horn, JLU Giessen
##
#############################################################################


#! @Description
#! This is the main function of the &AutoDoc; package. It can perform
#! any combination of the following three tasks:
#! <Enum>
#! <Item>
#!     It can (re)generate a scaffold for your package manual.
#!     That is, it can produce two XML files in &GAPDoc; format to be used as part
#!     of your manual: First, a file named <F>doc/PACKAGENAME.xml</F>
#!     (with your package's name substituted) which is used as
#!     main file for the package manual, i.e. this file sets the
#!     XML DOCTYPE and defines various XML entities, includes
#!     other XML files (both those generated by &AutoDoc; as well
#!     as additional files created by other means), tells &GAPDoc;
#!     to generate a table of content and an index, and more.
#!     Secondly, it creates a file <F>doc/title.xml</F> containing a title
#!     page for your documentation, with information about your package
#!     (name, description, version), its authors and more, based
#!     on the data in your <F>PackageInfo.g</F>.
#! </Item>
#! <Item>
#!     It can invoke <Ref Func='CreateAutomaticDocumentation'/> to scan your
#!     package for &AutoDoc; based documentation (defined using
#!     <Ref Func='DeclareOperationWithDocumentation'/> and its siblings. This will
#!     produce further XML files to be used as part of the package manual.
#! </Item>
#! <Item>
#!     It can use &GAPDoc; to generate PDF, text and HTML (with
#!     MathJaX enabled) documentation from the &GAPDoc; XML files it
#!     generated as well as additional such files provided by you. For
#!     this, it invokes <Ref Func='MakeGAPDocDoc' BookName='gapdoc'/>
#!     to convert the XML sources, and it also instructs &GAPDoc; to copy
#!     supplementary files (such as CSS style files) into your doc directory
#!     (see <Ref Func='CopyHTMLStyleFiles' BookName='gapdoc'/>).
#! </Item>
#! </Enum>
#! For more information and some examples, please refer to Chapter <Ref Label='Tutorials'/>.
#! <P/>
#! The parameters have the following meanings:
#! <List>
#!
#! <Mark><A>package_name</A></Mark>
#! <Item>
#!     The name of the package whose documentation should be(re)generated.
#! </Item>
#!
#!
#! <Mark><A>option_record</A></Mark>
#! <Item>
#!     <A>option_record</A> can be a record with some additional options.
#!     The following are currently supported:
#!     <List>
#!     <Mark><A>dir</A></Mark>
#!     <Item>
#!         This should be a string containing a (relative) path or a
#!         Directory() object specifying where the package documentation
#!         (i.e. the &GAPDoc; XML files) are stored.
#!         <Br/>
#!         <E>Default value: <C>"doc/"</C>.</E>
#!     </Item>
#!     <Mark><A>scaffold</A></Mark>
#!     <Item>
#!         This controls whether and how to generate scaffold XML files
#!         for the main and title page of the package's documentation. 
#!         <P/>
#!         The value should be either <K>true</K>, <K>false</K> or a
#!         record. If it is a record or <K>true</K> (the latter is
#!         equivalent to specifying an empty record), then this feature is
#!         enabled. It is also enabled if <A>opt.scaffold</A> is missing but the
#!         package's info record in <F>PackageInfo.g</F> has an <C>AutoDoc</C> entry.
#!         In all other cases (in particular if <A>opt.scaffold</A> is
#!         <K>false</K>), scaffolding is disabled.
#!         <P/>
#!
#!         If <A>opt.scaffold</A> is a record, it may contain the following entries.
#!
#### TODO: mention merging with PackageInfo.AutoDoc!
#!         <List>
#!
#!         <Mark><A>includes</A></Mark>
#!         <Item>
#!             A list of XML files to be included in the body of the main XML file.
#!             If you specify this list and also are using &AutoDoc; to document
#!             your operations via <Ref Func='DeclareOperationWithDocumentation'/>
#!             and its siblings, you can add <F>AutoDocMainFile.xml</F> to this list
#!             to control at which point the documentation produced by &AutoDoc;
#!             is inserted. If you do not do this, it will be added after the last
#!             of your own XML files.
#!         </Item>
#!
#!         <Mark><A>appendix</A></Mark>
#!         <Item>
#!             This entry is similar to <A>opt.scaffold.includes</A> but is used
#!             to specify files to include after the main body of the manual,
#!             i.e. typically appendices.
#!         </Item>
#!
#!         <Mark><A>bib</A></Mark>
#!         <Item>
#!             The name of a bibliography file, in Bibtex or XML format.
#!             If this key is not set, but there is a file <F>doc/PACKAGENAME.bib</F>
#!             then it is assumed that you want to use this as your bibliography.
#!         </Item>
#!
#### TODO: The 'entities' param is a bit strange. We should probably change it to be a bit more
#### general, as one might want to define other entities... For now, we do not document it
#### to leave us the choice of revising how it works.
####
####                 <Mark><A>entities</A></Mark>
####                 <Item>
####                     A list of package names which are used to define corresponding XML entities.
####                     For example, if set to a list containing the string <Q>SomePackage</Q>,
####                     then the following is added to the XML preamble:
####                     <Listing><![CDATA[<!ENTITY SomePackage '<Package>SomePackage</Package>'>]]></Listing>
####                     This allows you to write <Q>&amp;SomePackage;</Q> in your documentation
####                     to reference that package.
####                 </Item>
#!
#!         <Mark><A>TitlePage</A></Mark>
#!         <Item>
#!             A record whose entries are used to embellish the generated titlepage
#!             for the package manual with extra information, such as a copyright
#!             statement or acknowledgments. To this end, the names of the record
#!             components are used as XML element names, and the values of the
#!             components are outputted as content of these XML elements. For
#!             example, you could pass the following record to set a custom
#!             acknowledgements text:
#!             <Listing><![CDATA[
#!             rec( Acknowledgements := "Many thanks to ..." )]]></Listing>
#!             For a list of valid entries in the titlepage, please refer to the
#!             &GAPDoc; manual, specifically section <Ref Subsect='Title' BookName='gapdoc'/>
#!             and following.
#!         </Item>
#!
#!         </List>
#!     </Item>
#!
#!
#!     <Mark><A>autodoc</A></Mark>
#!     <Item>
#!         This controls whether and how to generate addition XML documentation files
#!         by scanning for &AutoDoc; documentation comments.
#!         <P/>
#!         The value should be either <K>true</K>, <K>false</K> or a
#!         record. If it is a record or <K>true</K> (the latter is
#!         equivalent to specifying an empty record), then this feature is
#!         enabled. It is also enabled if <A>opt.autodoc</A> is missing but the
#!         package depends (directly) on the &AutoDoc; package.
#!         In all other cases (in particular if <A>opt.autodoc</A> is
#!         <K>false</K>), this feature is disabled.
#!         <P/>
#!
#!         If <A>opt.autodoc</A> is a record, it may contain the following entries.
#!
#!         <List>
#!
#!         <Mark><A>files</A></Mark>
#!         <Item>
#!             A list of files (given by paths relative to the package directory)
#!             to be scanned for &AutoDoc; documentation comments.
#!             Usually it is more convenient to use <A>autodoc.scan_dirs</A>, see below.
#!         </Item>
#!
#!         <Mark><A>scan_dirs</A></Mark>
#!         <Item>
#!             A list of subdirectories of the package directory (given as relative paths)
#!             which &AutoDoc; then scans for .gi, .gd and .g files; all of these files
#!             are then scanned for &AutoDoc; documentation comments.
#!             <Br/>
#!             <E>Default value: <C>[ "gap", "lib", "examples", "examples/doc" ]</C>.</E>
#!         </Item>
#!
#!         <Mark><A>level</A></Mark>
#!         <Item>
#!             This defines the level of the created documentation. The default value is 0.
#!             When parts of the manual are declared with a higher value
#!             they will not be printed into the manual.
#!         </Item>
#!
#### TODO: Document section_intros later on.
#### However, note that thanks to the new AutoDoc comment syntax, the only remaining
#### use for this seems to be the ability to specify the order of chapters and
#### sections.
####                 <Mark><A>section_intros</A></Mark>
####                 <Item>
####                     TODO.
####                 </Item>
#!
#!         </List>
#!     </Item>
#!
#!
#!     <Mark><A>gapdoc</A></Mark>
#!     <Item>
#!         This controls whether and how to invoke &GAPDoc; to create HTML, PDF and text
#!         files from your various XML files.
#!         <P/>
#!         The value should be either <K>true</K>, <K>false</K> or a
#!         record. If it is a record or <K>true</K> (the latter is
#!         equivalent to specifying an empty record), then this feature is
#!         enabled. It is also enabled if <A>opt.gapdoc</A> is missing.
#!         In all other cases (in particular if <A>opt.gapdoc</A> is
#!         <K>false</K>), this feature is disabled.
#!         <P/>
#!
#!         If <A>opt.gapdoc</A> is a record, it may contain the following entries.
#!
#!         <List>
#!
#!
#### Note: 'main' is strictly speaking also used for the scaffold.
#### However, if one uses the scaffolding mechanism, then it is not
#### really necessary to specify a custom name for the main XML file.
#### Thus, the purpose of this parameter is to cater for packages
#### that have existing documentation using a different XML name,
#### and which do not wish to use scaffolding.
####
#### This explain why we only allow specifying gapdoc.main.
#### The scaffolding code will still honor it, though, just in case.
#!         <Mark><A>main</A></Mark>
#!         <Item>
#!             The name of the main XML file of the package manual.
#!             This exists primarily to support packages with existing manual
#!             which use a filename here which differs from the default.
#!             In particular, specifying this is unnecessary when using scaffolding.
#!             <Br/>
#!             <E>Default value: <C>PACKAGENAME.xml</C></E>.
#!         </Item>
#!
#!         <Mark><A>files</A></Mark>
#!         <Item>
#!             A list of files (given by paths relative to the package directory)
#!             to be scanned for &GAPDoc; documentation comments.
#!             Usually it is more convenient to use <A>gapdoc.scan_dirs</A>, see below.
#!         </Item>
#!
#!         <Mark><A>scan_dirs</A></Mark>
#!         <Item>
#!             A list of subdirectories of the package directory (given as relative paths)
#!             which &AutoDoc; then scans for .gi, .gd and .g files; all of these files
#!             are then scanned for &GAPDoc; documentation comments.
#!             <Br/>
#!             <E>Default value: <C>[ "gap", "lib", "examples", "examples/doc" ]</C>.</E>
#!         </Item>
#!
#!         </List>
#!     </Item>
#!
#!
#!     </List>
#! </Item>
#! </List>
#!
#! @Returns nothing
#! @Arguments package_name[, option_record ]
#! @ChapterInfo AutoDoc, The AutoDoc() function
DeclareGlobalFunction( "AutoDoc" );

