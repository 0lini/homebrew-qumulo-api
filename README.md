# Homebrew Qumulo API

Homebrew tap for installing the [Qumulo API](https://pypi.org/project/qumulo-api/) Python package.

For more information about Homebrew taps, see the [official documentation](https://docs.brew.sh/Taps).

## Installation

```bash
brew tap 0lini/qumulo-api
brew install qumulo-api
```

Learn more about [installing formulae](https://docs.brew.sh/FAQ#how-do-i-install-a-formula).

## Usage

After installation, the `qq` command-line tool will be available:

```bash
qq --version
qq --help
```

## What's Included

This formula installs:
- **qumulo-api**: Python API for Qumulo Core REST API
- All required dependencies (argcomplete, dataclasses-json, marshmallow, etc.)

## Requirements

- Python 3.13 (automatically installed as a dependency)

## Development

For general guidance on writing formulae, see the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook).

### Updating the Formula

When a new version of qumulo-api is released:

1. Update the `url` and `sha256` in [Formula/qumulo-api.rb](Formula/qumulo-api.rb)
2. Update all resource URLs and SHA256 checksums if dependencies changed
3. Test the installation:
   ```bash
   brew reinstall qumulo-api
   brew test qumulo-api
   ```

### Python-Specific Formulae

This formula uses Homebrew's Python virtualenv helpers. For details, see the [Python for Formula Authors](https://docs.brew.sh/Python-for-Formula-Authors) guide.

## License

This tap is maintained independently. The Qumulo API package has its own licensing terms.

## Contributing

Issues and pull requests are welcome!
