# Python packaging

## Quickstart

After coding your package, the best way to package it for distribution is through Python Setup Tools

### Packaging structure

BUNDLENAME/
	setup.py
	PACKAGE1/
		__init__.py
		REST_OF_YOUR_PACKAGE_FILES
	PACKAGE2/
		__init__.py
		REST_OF_YOUR_PACKAGE_FILES
	...
	
BUNDLENAME will be the public name for your distributable project
PACKAGEX will be each project's package

### Content of setup.py


```
from setuptools import setup

setup(name='BUNDLENAME',
      version='BUNDLEVERSION',
      description='BUNDLE DESCRIPTION',
      url='URL WHERE YOUR PROJECT WILL BE ACCESSIBLE',
      author='YOUR NAME',
      author_email='YOUR EMAIL',
      license='YOUR LICENSE (example: MIT)',
      packages=['PACKAGE1', 'PACKAGE2'],
      zip_safe=False)
```

### Register in PyPI

```
python setup.py register
```

Then it will be accessible at the following url

http://pypi.python.org/pypi/BUNDLENAME/BUNDLEVERSION

#### Upload distribution

This step is necessary to have a straightforward experience (pip install BUNDLENAME will install your package instead of downloading source code)

- To generate distribution code

```
python setup.py sdist
```

- To generate distribution code and upload to pypi

```
python setup.py sdist upload
```

- To generate distribution code, upload to pypi and register project

```
python setup.py register sdist upload
```
