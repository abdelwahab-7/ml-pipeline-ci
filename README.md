# ML Pipeline CI

This repository contains an automated ML model validation pipeline using GitHub Actions.

## Features

- Automated testing on all branches except main
- Linter checks with flake8
- Model environment validation with PyTorch
- Documentation artifacts

## Pipeline Steps

1. Set up Python 3.10 environment
2. Install dependencies from requirements.txt
3. Run linter checks
4. Verify model environment
5. Upload README.md as artifact