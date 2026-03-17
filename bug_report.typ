= Bug Report: ML Model CI YAML Workflow
==

This report details all bugs found in the original YAML workflow file and their solutions.

== Original Issues and Solutions

=== Bug 1: Missing Checkout Step

*Problem:* The workflow did not check out the repository code before trying to access files like `requirements.txt`. This caused the pipeline to fail because the runner had no access to any repository files.

*Solution:* Added `actions/checkout@v4` as the first step:

```yaml
- name: Checkout code
  uses: actions/checkout@v4
```

=== Bug 2: Empty Linter Check Step

*Problem:* The "Linter Check" step had no command to execute.

Original:
```yaml
- name: Linter Check
```

*Solution:* Added flake8 commands with appropriate checks:

```yaml
- name: Linter Check
  run: |
    pip install flake8
    flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
    flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
```

=== Bug 3: Incorrect Branch Trigger

*Problem:* The workflow was set to run only on the "main" branch, but the task required running on all branches except main.

Original:
```yaml
on:
  push:
    branches: main
```

*Solution:* Changed to `branches-ignore` to exclude main:

```yaml
on:
  push:
    branches-ignore: [main]
  pull_request:
```

=== Bug 4: Missing Artifact Upload Step

*Problem:* The workflow did not include uploading README.md as a project artifact.

*Solution:* Added final step using actions/upload-artifact:

```yaml
- name: Upload Project Documentation
  uses: actions/upload-artifact@v4
  with:
    name: project-doc
    path: README.md
```

=== Bug 5: Incomplete YAML Structure

*Problem:* The original YAML was missing some required fields and had broken formatting.

*Solution:* Ensured all steps have "uses" or "run" fields, and properly structured the workflow:
- All steps include either "uses" or "run"
- Proper nesting of jobs and steps
- Complete YAML structure with all required fields

== Summary of Fixes

- Added missing checkout step to access repository files
- Completed the empty linter check step with flake8 commands
- Modified trigger to run on all branches except main
- Added artifact upload for README.md documentation
- Completed missing YAML structure elements

The final workflow now:
- Triggers on push to any branch except main, plus pull requests
- Checks out repository code
- Sets up Python 3.10 environment
- Installs dependencies from requirements.txt
- Runs comprehensive linting checks
- Verifies PyTorch/model environment
- Uploads README.md as an artifact named "project-doc"
