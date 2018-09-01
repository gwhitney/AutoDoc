#############################################################################
##
##  AutoDoc package
##
##  Copyright 2018
##    Contributed by Glen Whitney, studioinfinity.org
##
##  Licensed under the GPL 2 or later.
##
#############################################################################
Print( "Pretend this is a code file.\n" );
Print( "(Even though we never use it that way.\n" );
#! @Title General Test
#! @Date 2018/08/30
#! @Chapter Test
#! This is dummy text
#! @BeginExampleSession
#! gap> S5 := SymmetricGroup(5);
#! Sym( [ 1 .. 5 ] )
#! gap> Size(S5);
#! 120
#! @EndExampleSession
#! And we wrap up with some dummy text
#! @Section Some categories
#!  Intro text
DeclareCategory("MyThings", IsObject);
DeclareCategoryCollections("MyThings");
Now here is some text with a bunch of &!$%*!/ weird things in it. But that
should be OK, nothing should end up in a weird place.
#! @Section Extend coverage
#! And now we can test a variety of features of <Package>AutoDoc</Package>
#! which are not tested by processing the main manual.
#! @Description This category is implemented via a DeclareSynonym.
#!    Yet it will show up properly
#! @ItemType Filt
#! @Arguments obj
DeclareSynonym( "IsMyIntersectionObj", IsMyFirstObj and IsMySecondObj );
#! To see how this works, examine the following code
#! @HereCode
a := MyFirstObj( gens );
if IsMySecondObj( a ) then
   b := IsMyIntersectionObj( a );
fi;
### b will only ever be set to true, if it is set at all.
#! @EndCode
#! We can also specify the type of methods
#! @Description This is a special method for handling tough cases.
#! @ItemType Meth
InstallOtherMethod( GeneralOp, "for the tough cases",
  IsIdenticalObj,
  [IsAToughie, IsEvenWorse],
  function (t, w) return DoStuff(t, w);
end );
#! @BeginGroup Group1
#! @GroupTitle A family of operations
#! @GroupInitialArguments order

#! @Description
#!  First sentence.
DeclareOperation( "FirstOperation", [ IsInt ] );

#! @Description
#!  Second sentence.
#! @Arguments ambient_group
DeclareOperation( "SecondOperation", [ IsInt, IsGroup ] );

#! @EndGroup

## .. Stuff ..

#! @Description
#!  Third sentence.
#! @Group Group1
KeyDependentOperation( "ThirdOperation", IsGroup, IsInt, "prime orders");
#! The coverage of this test file could be extended further.
