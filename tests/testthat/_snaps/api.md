# cli_alert_warning works [plain]

    Code
      cli::cli_alert_warning(
        "This package hasn't been tested with this Bugzilla version.")
    Message <cliMessage>
      ! This package hasn't been tested with this Bugzilla version.

# cli_alert_warning works [ansi]

    Code
      cli::cli_alert_warning(
        "This package hasn't been tested with this Bugzilla version.")
    Message <cliMessage>
      [33m![39m This package hasn't been tested with this Bugzilla version.

# cli_alert_warning works [unicode]

    Code
      cli::cli_alert_warning(
        "This package hasn't been tested with this Bugzilla version.")
    Message <cliMessage>
      ! This package hasn't been tested with this Bugzilla version.

# cli_alert_warning works [fancy]

    Code
      cli::cli_alert_warning(
        "This package hasn't been tested with this Bugzilla version.")
    Message <cliMessage>
      [33m![39m This package hasn't been tested with this Bugzilla version.

# cli_alert_danger [plain]

    Code
      cli::cli_alert_danger("Not authenticated on this site.")
    Message <cliMessage>
      x Not authenticated on this site.
    Code
      cli::cli_alert_success("Authenticated on this site!")
    Message <cliMessage>
      v Authenticated on this site!

# cli_alert_danger [ansi]

    Code
      cli::cli_alert_danger("Not authenticated on this site.")
    Message <cliMessage>
      [31mx[39m Not authenticated on this site.
    Code
      cli::cli_alert_success("Authenticated on this site!")
    Message <cliMessage>
      [32mv[39m Authenticated on this site!

# cli_alert_danger [unicode]

    Code
      cli::cli_alert_danger("Not authenticated on this site.")
    Message <cliMessage>
      ✖ Not authenticated on this site.
    Code
      cli::cli_alert_success("Authenticated on this site!")
    Message <cliMessage>
      ✔ Authenticated on this site!

# cli_alert_danger [fancy]

    Code
      cli::cli_alert_danger("Not authenticated on this site.")
    Message <cliMessage>
      [31m✖[39m Not authenticated on this site.
    Code
      cli::cli_alert_success("Authenticated on this site!")
    Message <cliMessage>
      [32m✔[39m Authenticated on this site!

# cli_alert_dangers [plain]

    Code
      cli::cli_alert_danger("Key not valid or not set.")
    Message <cliMessage>
      x Key not valid or not set.

# cli_alert_dangers [ansi]

    Code
      cli::cli_alert_danger("Key not valid or not set.")
    Message <cliMessage>
      [31mx[39m Key not valid or not set.

# cli_alert_dangers [unicode]

    Code
      cli::cli_alert_danger("Key not valid or not set.")
    Message <cliMessage>
      ✖ Key not valid or not set.

# cli_alert_dangers [fancy]

    Code
      cli::cli_alert_danger("Key not valid or not set.")
    Message <cliMessage>
      [31m✖[39m Key not valid or not set.

