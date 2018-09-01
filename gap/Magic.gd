#############################################################################
##
##  AutoDoc package
##
##  Copyright 2012-2016
##    Sebastian Gutsche, University of Kaiserslautern
##    Max Horn, Justus-Liebig-Universität Gießen
##
## Licensed under the GPL 2 or later.
##
#############################################################################

#! @Chapter AutoDoc

#! @Section The AutoDoc() function

#! @Description
#! This is the main function of the &AutoDoc; package. It can perform
#! any combination of the following four tasks:
#! <Enum>
#! <Item>
#!     It can (re)generate a scaffold for your package manual.
#!     That is, it can produce two XML files in &GAPDoc; format to be used as part
#!     of your manual: First, a file named <F>doc/PACKAGENAME.xml</F>
#!     (with your package's name substituted) which is used as
#!     main XML file for the package manual, i.e. this file sets the
#!     XML doctype and defines various XML entities, includes
#!     other XML files (both those generated by &AutoDoc; as well
#!     as additional files created by other means), tells &GAPDoc;
#!     to generate a table of content and an index, and more.
#!     Secondly, it creates a file <F>doc/title.xml</F> containing a title
#!     page for your documentation, with information about your package
#!     (name, description, version), its authors and more, based
#!     on the data in your <F>PackageInfo.g</F>.
#! </Item>
#! <Item>
#!     It can scan your package for &AutoDoc; based documentation (by using &AutoDoc;
#!     tags and the Autodoc command.
#!     This will
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
#! <Item>
#!     It can create a maketest.g file which tests that all of the examples
#!     in the generated documentation perform as documented.
#! </Item>
#! </Enum>
#! For more information and some examples, please refer to Chapter <Ref Label='Tutorials'/>.
#! <P/>
#! The parameters have the following meanings:
#! <List>
#!
#! <Mark><A>package</A></Mark>
#! <Item>
#!     The purpose of this parameter is twofold: to determine the package
#!     directory in which &AutoDoc; will operate, and to find the metadata
#!     concerning the package being documented. The parameter is either a
#!     string, an <C>IsDirectory</C> object, or omitted.
#!     In the first case, &AutoDoc; interprets the string as the name of a
#!     package, uses the metadata of the first package known to &GAP;
#!     with that name, and uses the <C>InstallationPath</C> specified in that
#!     metadata as the package directory. The other cases directly specify the
#!     package directory, either given by the <C>IsDirectory</C> object or as
#!     the <C>DirectoryCurrent()</C> if the <A>package</A> parameter is
#!     omitted. In these cases, the package directory must contain a
#!     <F>PackageInfo.g</F> file, and &AutoDoc; extracts all needed metadata
#!     from that. The <C>IsDirectory</C> form is for example useful if you
#!     have multiple versions of the package around and want to make sure the
#!     documentation of the correct version is built.
#!     <P/>
#!     Note that when using <C>AutoDocWorksheet</C>
#!     (see <Ref Sect='Chapter_AutoDoc_worksheets_Section_Worksheets' />), there
#!     is no parameter corresponding to <A>package</A> and so the "package
#!     directory" is always the <C>DirectoryCurrent()</C> and there is no
#!     metadata.
#! </Item>
#!
#!
#! <Mark><A>optrec</A></Mark>
#! <Item>
#!     <A>optrec</A> can be a record with some additional options.
#!     The following are currently supported:
#!     <List>
#!     <Mark><A>dir</A></Mark>
#!     <Item>
#!         This should either be a string, in which case it must be a path
#!         <E>relative</E> to the specified package directory, or a
#!         <C>Directory()</C> object. (Thus, the only way to designate an
#!         absolute directory is with a <C>Directory()</C> object.) This
#!         option specifies where the package documentation
#!         (e.g. the &GAPDoc; XML or the manual PDF, etc.) files are stored
#!         and/or will be generated.
#!         <Br/>
#!         <E>Default value: <C>"doc/"</C>.</E>
#!     </Item>
#!     <Mark><A>scaffold</A></Mark>
#!     <Item>
#!         This controls whether and how to generate scaffold XML files
#!         for the package documentation.
#!         <P/>
#!         The value should be either <K>true</K>, <K>false</K> or a
#!         record. If it is a record or <K>true</K> (the latter is
#!         equivalent to specifying an empty record), then this feature is
#!         enabled. It is also enabled if <A>opt.scaffold</A> is missing but the
#!         package's info record in <F>PackageInfo.g</F> has an <C>AutoDoc</C> entry.
#!         In all other cases (in particular if <A>opt.scaffold</A> is
#!         <K>false</K>), scaffolding is disabled.
#!         <P/>
#!         If scaffolding is enabled, and <A>PackageInfo.AutoDoc</A> exists, then it is
#!         assumed to be a record, and its contents are used as default values for
#!         the scaffold settings.
#!         <P/>
#!
#!         If <A>opt.scaffold</A> is a record, it may contain the following entries.
#!
#!         <List>
#!
#!         <Mark><A>includes</A></Mark>
#!         <Item>
#!             A list of XML files to be included in the body of the main XML file.
#!             If you specify this list and also are using &AutoDoc; to document
#!             your operations with &AutoDoc; comments,
#!             you can add <F>_AutoDocMainFile.xml</F> to this list
#!             to control at which point the documentation produced by &AutoDoc;
#!             is inserted. If you do not do this, it will be added after the last
#!             of your own XML files.
#!         </Item>
#!
#!         <Mark><A>index</A></Mark>
#!         <Item>
#!             By default, the scaffold creates an index. If you do not want an index,
#!             set this to <K>false</K>.
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
#!             The name of a bibliography file, in BibTeX or XML format.
#!             If this key is not set, but there is a file <F>doc/PACKAGENAME.bib</F>
#!             then it is assumed that you want to use this as your bibliography.
#!         </Item>
#!
#!         <Mark><A>entities</A></Mark>
#!         <Item>
#!             A record whose keys are taken as entity names, set to the corresponding
#!             (string) values. For example, if you pass the record <Q>SomePackage</Q>,
#!             <Listing><![CDATA[
#!             rec( SomePackage := "<Package>SomePackage</Package>",
#!                  RELEASEYEAR := "2015" )]]></Listing>
#!             then the following entity definitions are added to the XML preamble:
#!             <Listing><![CDATA[<!ENTITY SomePackage '<Package>SomePackage</Package>'>
#!             <!ENTITY RELEASEYEAR '2015'>]]></Listing>
#!             This allows you to write <Q>&amp;SomePackage;</Q> and <Q>&amp;RELEASEYEAR;</Q>
#!             in your documentation, which will be replaced by respective values specified
#!             in the entities definition.
#!         </Item>
#!
#!         <Mark><A>TitlePage</A></Mark>
#!         <Item>
#!             A record whose entries are used to embellish the generated title page
#!             for the package manual with extra information, such as a copyright
#!             statement or acknowledgments. To this end, the names of the record
#!             components are used as XML element names, and the values of the
#!             components are outputted as content of these XML elements. For
#!             example, you could pass the following record to set a custom
#!             acknowledgements text:
#!             <Listing><![CDATA[
#!             rec( Acknowledgements := "Many thanks to ..." )]]></Listing>
#!             For a list of valid entries in the title page, please refer to the
#!             &GAPDoc; manual, specifically section <Ref Subsect='TitlePage' BookName='gapdoc'/>.
#!         </Item>
#!         <Mark><A>MainPage</A></Mark>
#!         <Item>
#!             If scaffolding is enabled, by default a main XML file is generated (this
#!             is the file which contains the XML doctype and more). If you do not
#!             want this (e.g. because you have a handwritten main XML file), but
#!             still want &AutoDoc; to generate a title page for you, you can set this
#!             option to <K>false</K>
#!         </Item>
#!         <Mark><A>document_class</A></Mark>
#!         <Item>
#!             Sets the document class of the resulting PDF. The value can either be a string
#!             which has to be the name of the new document class, a list containing this string, or
#!             a list of two strings. Then the first one has to be the document class name, the second one
#!             the option string ( contained in [ ] ) in LaTeX.
#!         </Item>
#!         <Mark><A>latex_header_file</A></Mark>
#!         <Item>
#!             Replaces the standard header from &GAPDoc; completely with the header in this LaTeX file.
#!             Please be careful here, and look at GAPDoc's latexheader.tex file for an example.
#!         </Item>
#!         <Mark><A>gapdoc_latex_options</A></Mark>
#!         <Item>
#!             Must be a record with entries which can be understood by SetGapDocLaTeXOptions. Each entry can be a string, which
#!             will be given to &GAPDoc; directly, or a list containing of two entries: The first one must be the string "file",
#!             the second one a filename. This file will be read and then its content is passed to &GAPDoc; as option with the name
#!             of the entry.
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
#!             <Label Name="AutodocFilesOption"/>
#!             A list of files (given by paths relative to the package directory)
#!             to be scanned for &AutoDoc; documentation comments.
#!             Usually it is more convenient to use <A>autodoc.scan_dirs</A>, see below.
#!             However, the files in this list are always scanned **before**
#!             the ones found by <A>scan_dirs</A>, and they are scanned in
#!             the order listed, so this option can be useful for controlling
#!             the order that &AutoDoc; processes files, which in turn
#!             can be useful to ensure that your manual is presented in the
#!             desired order. For example, you might use this option to
#!             designate a "master file" which declares all chapters in the
#!             desired order. Those chapters can then be filled in by
#!             documentation in your source files, which may be processed in an
#!             order not relevant to the flow of your documentation.
#!         </Item>
#!
#!         <Mark><A>scan_dirs</A></Mark>
#!         <Item>
#!             A list of subdirectories of the package directory (given as relative paths)
#!             which &AutoDoc; then scans for .gi, .gd, .g, and .autodoc files; all of these files
#!             are then scanned for &AutoDoc; documentation comments.
#!             <Br/>
#!             <E>Default value: <C>[ ".", "gap", "lib", "examples", "examples/doc" ]</C>.</E>
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
#### This explains why we only allow specifying gapdoc.main.
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
#!             <E>Default value: <C>[ ".", "gap", "lib", "examples", "examples/doc" ]</C>.</E>
#!         </Item>
#!         <Mark><A>gap_root_relative_path</A></Mark>
#!         <Item>
#!             Either a boolean, or a string containing a relative path.
#!             By default (if this option is not set, or is set to <K>false</K>),
#!             references in the generated documentation referring to external documentation
#!             (such as the GAP manual) are encoded using absolute paths.
#!             This is fine as long as the documentation stays on only a single
#!             computer, but is problematic when preparing documentation that should be
#!             used on multiple computers, e.g., when creating a distribution archive of
#!             a GAP package.<Br/>
#!             Thus, if a relative path is provided via this option (or if it is set to true,
#!             in which case the relative path <F>../../..</F> is used), then &AutoDoc;
#!             and &GAPDoc; attempt to replace all absolute paths in references to GAP
#!             manuals by paths based on this relative path.<P/>
#!             
#!             On a technical level, &AutoDoc; passes the relative path to the
#!             <A>gaproot</A> parameter of <Ref Func='MakeGAPDocDoc'
#!             BookName='gapdoc'/><P/>
#!         </Item>
#!
#!         </List>
#!     </Item>
## This is the maketest part. Still under construction.
#!        <Mark><A>maketest</A></Mark>
#!        <Item>
#!          The maketest item can be true or a record. When it is true,
#!          a simple maketest.g is created in the main package directory,
#!          which can be used to test the examples from the manual. As a record,
#!          the entry can have the following entries itself, to specify some options.
#!          <List>
#!          <Mark>filename</Mark>
#!          <Item>
#!            Sets the name of the test file.
#!          </Item>
#!          <Mark>commands</Mark>
#!          <Item>
#!            A list of strings, each one a command, which
#!            will be executed at the beginning of the test file.
#!          </Item>
#!          </List>
#!        </Item>
#!
#!     </List>
#! </Item>
#! </List>
#!
#! @Returns nothing
#! @Arguments [package], [optrec]
DeclareGlobalFunction( "AutoDoc" );


#! @Section Examples
#!
#! Some basic examples for using <C>AutoDoc</C> were already shown in
#! Chapter <Ref Label='Tutorials'/>.
