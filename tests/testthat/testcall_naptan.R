# Tests for call_naptan() function ----

# Check if data is correct type
output <- call_naptan()
test_that("output is list", {
  expect_type(output, "list")
})

# Check if data is in correct format
test_that("output is in expected format", {
  expect_equal(ncol(output), 43)
  expect_equal(names(output)[28:31], c("Easting", "Northing", "Longitude", "Latitude"))
})

# Test using AtocCode (300)
output <- call_naptan(atco = 300)
test_that("output as expected using atco == 300", {
  expect_equal(ncol(output), 43)
  expect_equal(names(output)[28:31], c("Easting", "Northing", "Longitude", "Latitude"))
})

# Test using multiple Atco codes
output <- call_naptan(atco = c(300, 690))
test_that("output as expected using multiple Atco codes", {
  expect_true(nrow(output) > nrow(call_naptan(atco = 300)))
  expect_equal(nrow(output),
               sum(
                 nrow(call_naptan(atco = 300)),
                 nrow(call_naptan(atco = 690))
               ))
  expect_equal(ncol(output), 43)
  expect_equal(names(output)[28:31], c("Easting", "Northing", "Longitude", "Latitude"))
})

# Expect error if unexpected Atco codes are entered
test_that("function errors when inappropriate Atco code used", {
  expect_error(call_naptan("000"),
               "The following ATCO area codes do not exist: 000 To display all valid atco codes, run lookup_atco_codes()")
})