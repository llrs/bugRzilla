# create_bugzilla_key() works [plain]

    Code
      create_bugzilla_key()
    Message <cliMessage>
      i Reading cached keys on '/home/lluis/.cache/R/bugRzilla/.Renviron'.
      v Found key `R_BUGZILLA`.
      v Using key `R_BUGZILLA`.
      v Authenticated on this site!

# create_bugzilla_key() works [unicode]

    Code
      create_bugzilla_key()
    Message <cliMessage>
      ℹ Reading cached keys on '/home/lluis/.cache/R/bugRzilla/.Renviron'.
      ✔ Found key `R_BUGZILLA`.
      ✔ Using key `R_BUGZILLA`.
      ✔ Authenticated on this site!

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

