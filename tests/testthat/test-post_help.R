# yes <- c("Yes", "Definitely", "Positive", "For sure", "Yup", "Yeah",
#          "Absolutely")
# no <- c("Not sure", "Not now", "Negative", "No", "Nope", "Absolutely not")
#
# cli::test_that_cli(configs = c("plain"), "read_documentation() works",{
#     expect_snapshot({
#         expect_equal(read_documentation(), "Cancel")
#         # expect_equal(read_documentation(), no)
#         # expect_equal(read_documentation(), yes)
#     })
# })

# test_that("ask_confirmation works", {
#     vcr::use_cassette("ask_confirmation", {
#         ac <- ask_confirmation(title = NULL, positive = yes, negative = no)
#     })
#     expect_equal(sample(positive, 1), sample(negative, 2))
# })
