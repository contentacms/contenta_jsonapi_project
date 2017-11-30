# asm89/stacks-cors

This folder contains patches for the library ams89/stack-cors that can't be applied due to some particular cirmcumstance.

## Patches

#### pull_request_42.patch
  - **Patch created on:**
    - November 29 2017 06:22:06 PM (1511979726)
  - **Original source:**
    - The patch is based out of the ams89/stack-cors PR [#42](https://github.com/asm89/stack-cors/pull/42)
  - **Description patch:**
    - A Github PR Patch for [#42](https://github.com/asm89/stack-cors/pull/42) was been used in the ContentaCMS Project before. This had to change due that in the ams89/stack-cors [1.1.0](https://github.com/asm89/stack-cors/tree/1.1.0) release, a [.gitattributes](https://github.com/asm89/stack-cors/blob/1.1.0/.gitattributes) file was added which specifies that the test folder should be ignored on export. Since composer downloads packages as a git archive, the gitattributes is applied, and files in the original repo are ignored when downloaded with composer. The PR which we were using as a patch modifies tests on the test folder and the test folder is one of the folder that is ignored in the [.gitattributes](https://github.com/asm89/stack-cors/blob/1.1.0/.gitattributes) and making the patch failing when applied. For this reason `pull_request_42.patch` was created. It contains only the changes made to the `src/` folder on [#42](https://github.com/asm89/stack-cors/pull/42).
  - **Notes:**
      - If the PR changes, we have no way of tracking it and the currently patch will be outdated. There is a low possibility of this happening since the PR has not been updated since 8 months from the time of writing.
  - **Instructions to regenerate patch:**
    ```bash
      $ git clone git@github.com:asm89/stack-cors.git
      $ cd stack-cors
      $ git checkout feat-originmatch
      $ git diff master -- src > pull_request_42.patch
      s rm <contentacms_root>/patches/asm89_stack-cors/pull_request_42
      $ cp pull_request_42 <contentacms_root>/patches/asm89_stack-cors/
      $ cd ../
      $ rm -rf stack-cors
    ```
