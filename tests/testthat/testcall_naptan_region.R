test_that("Correct error message given when a region not found", {
  expect_error(call_naptan_region("aaaa"))
  expect_error(call_naptan_region("aaaa"),
               "No ATCO codes found for the specified region string: aaaa")
})


test_that("Lookup can return results for a single region", {
  expect_message(call_naptan_region("west yorkshire"), "Returning data for area codes: 450 West Yorkshire")
  
  expect_type(call_naptan_region("west yorkshire"), "list")
  
})

test_that("Lookup can return results for broad region keyword", {
  expect_message(call_naptan_region("yorkshire"), 
                 "Returning data for area codes: 220 East Riding of Yorkshire, 320 North Yorkshire, 370 South Yorkshire, 450 West Yorkshire")
  
  expect_type(call_naptan_region("yorkshire"), "list")
  
})
