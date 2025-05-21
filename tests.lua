-- Tests. Run simply with lua `tests.lua`

lu = require('luaunit')
H  = require('hairdresser')

TestFold = {}
   function TestFold:setUp()
      public = {}
      public.thresh = 2
      abit = 0.001
   end

   function TestFold:testShouldNotFoldAtZero()
      lu.assertEquals(H:fold(0), 0)
   end

   function TestFold:testShouldNotFoldBelowPosThresh()
      lu.assertEquals(H:fold(1), 1)
   end
   function TestFold:testShouldNotFoldBelowNegThresh()
      lu.assertEquals(H:fold(-1), -1)
   end

   function TestFold:testShouldNotFoldAtPosThresh()
      lu.assertEquals(H:fold(public.thresh), public.thresh)
   end
   function TestFold:testShouldNotFoldAtNegThresh()
      lu.assertEquals(H:fold(-public.thresh), -public.thresh)
   end

   function TestFold:testShouldFoldAbitAbovePosThresh()
      lu.assertNotEquals(H:fold(public.thresh + abit), public.thresh)
      lu.assertEquals(H:fold(public.thresh + abit), public.thresh - abit)
   end
   function TestFold:testShouldFoldAbitBelowNegThresh()
      lu.assertNotEquals(H:fold(-public.thresh + abit), -public.thresh)
      lu.assertEquals(H:fold(-public.thresh + abit), -public.thresh + abit)
   end

   function TestFold:testShouldFoldAbovePosThresh()
      lu.assertEquals(H:fold(3), 1)
   end
   function TestFold:testShouldFoldBelowNegThresh()
      lu.assertEquals(H:fold(-3), -1)
   end

   function TestFold:testShouldFoldAbovePosThresh()
      lu.assertEquals(H:fold(3), 1)
   end
   function TestFold:testShouldFoldBelowNegThresh()
      lu.assertEquals(H:fold(-3), -1)
   end

   function TestFold:testShouldFoldUpwardToZero()
      lu.assertEquals(H:fold(public.thresh * 2), 0)
   end
   function TestFold:testShouldFoldDownwardToZero()
      lu.assertEquals(H:fold(-public.thresh * 2), 0)
   end

   function TestFold:testShouldFoldAllTheWayUp()
      lu.assertEquals(H:fold(public.thresh * 3), -public.thresh)
   end
   function TestFold:testShouldFoldAllTheWayDown()
      lu.assertEquals(H:fold(-public.thresh * 3), public.thresh)
   end

   function TestFold:testShouldFoldUpwardSecordOrder()
      lu.assertAlmostEquals(H:fold(public.thresh*3 + abit), -public.thresh+abit, 0.001)
   end
   function TestFold:testShouldFoldDownwardSecondOrder()
      lu.assertAlmostEquals(H:fold(-public.thresh*3 + abit), public.thresh-abit, 0.001)
   end

   function TestFold:testShouldFoldUpwardToEurorackMax()
      lu.assertEquals(H:fold(10), 2)
   end
   function TestFold:testShouldFoldDownwardToEurorackMin()
      lu.assertEquals(H:fold(-10), -2)
   end

   function TestFold:testShouldFoldUpwardBeyondEurorackMax()
      lu.assertAlmostEquals(H:fold(15.1), -0.9, 0.001)
   end
   function TestFold:testShouldFoldDownwardToEurorackMin()
      lu.assertAlmostEquals(H:fold(-15.1), 0.9, 0.001)
   end

TestWrap = {}
   function TestWrap:setUp()
      public = {}
      public.thresh = 2
      abit = 0.001
   end

   function TestWrap:testShouldNotWrapAtZero()
      lu.assertEquals(H:wrap(0), 0)
   end

   function TestWrap:testShouldNotWrapBelowPosThresh()
      lu.assertEquals(H:wrap(1), 1)
   end
   function TestWrap:testShouldNotWrapBelowNegThresh()
      lu.assertEquals(H:wrap(-1), -1)
   end

   function TestWrap:testShouldNotWrapAtPosThresh()
      lu.assertEquals(H:wrap(public.thresh), public.thresh)
   end
   function TestWrap:testShouldNotWrapAtNegThresh()
      lu.assertEquals(H:wrap(-public.thresh), -public.thresh)
   end

   function TestWrap:testShouldWrapAbitAbovePosThresh()
      lu.assertNotEquals(H:wrap(public.thresh + abit), public.thresh)
      lu.assertEquals(H:wrap(public.thresh + abit), -public.thresh + abit)
   end
   function TestWrap:testShouldWrapAbitBelowNegThresh()
      lu.assertNotEquals(H:wrap(-public.thresh + abit), -public.thresh)
      lu.assertEquals(H:wrap(-public.thresh - abit), public.thresh - abit)
   end

   function TestWrap:testShouldWrapAbovePosThresh()
      lu.assertEquals(H:wrap(3), 1)
   end
   function TestWrap:testShouldWrapBelowNegThresh()
      lu.assertEquals(H:wrap(-3), -1)
   end

   function TestWrap:testShouldWrapAbovePosThresh()
      lu.assertEquals(H:wrap(3), -1)
   end
   function TestWrap:testShouldWrapBelowNegThresh()
      lu.assertEquals(H:wrap(-3), 1)
   end

   function TestWrap:testShouldWrapUpwardToZero()
      lu.assertEquals(H:wrap(public.thresh * 2), 0)
   end
   function TestWrap:testShouldWrapDownwardToZero()
      lu.assertEquals(H:wrap(-public.thresh * 2), 0)
   end

   function TestWrap:testShouldWrapAllTheWayUp()
      lu.assertEquals(H:wrap(public.thresh * 3), public.thresh)
   end
   function TestWrap:testShouldWrapAllTheWayDown()
      lu.assertEquals(H:wrap(-public.thresh * 3), -public.thresh)
   end

   function TestWrap:testShouldWrapUpwardSecordOrder()
      lu.assertAlmostEquals(H:wrap(public.thresh*3 + abit), -public.thresh+abit, 0.001)
   end
   function TestWrap:testShouldWrapDownwardSecondOrder()
      lu.assertAlmostEquals(H:wrap(-public.thresh*3 + abit), -public.thresh+abit, 0.001)
   end

   function TestWrap:testShouldWrapUpwardToEurorackMax()
      lu.assertEquals(H:wrap(10), 2)
   end
   function TestWrap:testShouldWrapDownwardToEurorackMin()
      lu.assertEquals(H:wrap(-10), -2)
   end

   function TestWrap:testShouldWrapUpwardBeyondEurorackMax()
      lu.assertAlmostEquals(H:wrap(15.1), -0.9, 0.001)
   end
   function TestWrap:testShouldWrapDownwardToEurorackMin()
      lu.assertAlmostEquals(H:wrap(-15.1), 0.9, 0.001)
   end

TestClip = {}
   function TestClip:setUp()
     public = {}
     public.thresh = 2
     abit = 0.001
   end

   function TestFold:testShouldNotClipAtZero()
      lu.assertEquals(H:clip(0), 0)
   end

   function TestClip:testShouldNotClipBelowPosThresh()
      lu.assertEquals(H:clip(1), 1)
   end
   function TestClip:testShouldNotClipBelowNegThresh()
      lu.assertEquals(H:clip(-1), -1)
   end

   function TestClip:testShouldNotClipAtPosThresh()
      lu.assertEquals(H:clip(public.thresh), public.thresh)
   end
   function TestClip:testShouldNotClipAtNegThresh()
      lu.assertEquals(H:clip(-public.thresh), -public.thresh)
   end

   function TestClip:testShouldClipAbitAbovePosThresh()
      lu.assertEquals(H:clip(public.thresh + abit), public.thresh)
   end
   function TestClip:testShouldClipAbitBelowNegThresh()
      lu.assertEquals(H:clip(-public.thresh - abit), -public.thresh)
   end

   function TestClip:testWillClipUpwardNoMatterWhat()
      lu.assertEquals(H:clip(1000), public.thresh)
   end
   function TestClip:testWillClipDownwardNoMatterWhat()
      lu.assertEquals(H:clip(-1000), -public.thresh)
   end

os.exit( lu.LuaUnit.run() )
