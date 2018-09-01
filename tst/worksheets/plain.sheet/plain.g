#############################################################################
##
##  AutoDoc package
##
##  Test the behavior of AutoDoc in plain text mode
##
##  Copyright 2018
##    Contributed by Glen Whitney, studioinfinity.org
##
## Licensed under the GPL 2 or later.
##
#############################################################################
Print( "Pretend this is a code file.\n" );
Print( "(Even though we never use it that way.)\n" );
#! @Title Plain Text Mode Test
#! @Date 2018/08/30
#! @AutoDocPlainText
@Chapter Test
This is dummy text
@BeginExampleSession
gap> S5 := SymmetricGroup(5);
Sym( [ 1 .. 5 ] )
gap> Size(S5);
120
@EndExampleSession
And we wrap up with some dummy text
@EndAutoDocPlainText
Print( "This line in the file should not be processed.\n" );
#! But this should produce more text.
