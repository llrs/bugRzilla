# create_bugzilla_key() works [plain]

    Code
      create_bugzilla_key()
    Message <cliMessage>
      v Found key `R_BUGZILLA`.
      v Using key `R_BUGZILLA`.
      x Not authenticated on this site.

# create_bugzilla_key() works [unicode]

    Code
      create_bugzilla_key()
    Message <cliMessage>
      ✔ Found key `R_BUGZILLA`.
      ✔ Using key `R_BUGZILLA`.
      ✖ Not authenticated on this site.

# set_key works

    Code
      sk <- set_key()
    Message <cliMessage>
      v Found key `R_BUGZILLA`.
      v Using key `R_BUGZILLA`.
    Code
      expect_equal(write_renviron(key = sk, value = sk, file = app_file()), NULL)
    Message <cliMessage>
      v Storing key on '~/.cache/R/bugRzilla/.Renviron'.

# check_key() works [plain]

    Code
      check_key(key_name = missing_key(), verbose = FALSE)
    Output
      [1] TRUE

# check_key() works [unicode]

    Code
      check_key(key_name = missing_key(), verbose = FALSE)
    Output
      [1] TRUE

# use_key() works [plain]

    Code
      use_key(missing_key())
    Message <cliMessage>
      v Using key `R_BUGZILLA`.

# use_key() works [unicode]

    Code
      use_key(missing_key())
    Message <cliMessage>
      ✔ Using key `R_BUGZILLA`.

# valid_key() works [plain]

    Code
      valid_key(key = "hgfcchg12")
    Output
      [1] TRUE

# valid_key() works [ansi]

    Code
      valid_key(key = "hgfcchg12")
    Output
      [1] TRUE

# valid_key() works [unicode]

    Code
      valid_key(key = "hgfcchg12")
    Output
      [1] TRUE

# valid_key() works [fancy]

    Code
      valid_key(key = "hgfcchg12")
    Output
      [1] TRUE

