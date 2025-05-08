fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios publish

```sh
[bundle exec] fastlane ios publish
```

Posts message to Slack. Environment variables:

SLACK_URL: Slack incoming webhook (required).

SLACK_BUILD_URL: Web url to CI build, used in a button. (optional).

SLACK_RELEASE_REPO_URL: Web url to release repo, used in a button. (optional).

- message: Message to post.

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
