test_that(
  "chcking function diff_region_state() works",{

          expect_equal(nrow(diff_region_state("AK",1999)),1)
          expect_equal(nrow(diff_region_state("AK",2022)),0)

    }
)
