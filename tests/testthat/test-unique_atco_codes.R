test_that("Expected number of ATCO codes are returned", {
  expect_equal(nrow(lookup_atco_codes()), 148)
})

test_that("Full area name search returns expected value", {
  expect_equal(nrow(lookup_atco_codes(area_name = "West Yorkshire")), 1)
  expect_equal(lookup_atco_codes(area_name = "West Yorkshire")$AtcoAreaCode, "450")
})

test_that("Partial area name search works in all cases", {
  expect_equal(nrow(lookup_atco_codes(area_name = "YORKSHIRE")), 4)
  expect_equal(nrow(lookup_atco_codes(area_name = "west")), 8)
})

test_that("Regex rules can be applied to area name search", {
  expect_equal(nrow(lookup_atco_codes(area_name = "west|yorkshire")), 11)
  expect_true(nrow(lookup_atco_codes(area_name = "^t")) !=  nrow(lookup_atco_codes(area_name = "t")))
  
})

test_that("Country lookup returns correct number of rows", {
  expect_equal(nrow(lookup_atco_codes(country = "ENG")), 89)
  expect_equal(nrow(lookup_atco_codes(country = "WAL")), 22)
  expect_equal(nrow(lookup_atco_codes(country = "SCO")), 32)
})

test_that("Expected error is returned for region and country lookup", {
  expect_warning(lookup_atco_codes(area_name = "aaaa"), "No results found for search string aaaa")
  expect_error(lookup_atco_codes(country = "ENGLAND"))
})

