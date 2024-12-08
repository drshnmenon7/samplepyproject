from setuptools import setup, find_packages

setup(
    name="samplepyproject",
    version="0.1.0",
    description="A sample Python project",
    author="Your Name",
    author_email="your-email@example.com",
    url="https://github.com/drshnmenon7/samplepyproject",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    include_package_data=True,
    install_requires=[
        # List your project's dependencies here, e.g.,
        # 'requests>=2.25.1',
    ],
    entry_points={
        'console_scripts': [
            'samplepyproject = sample.__main__:main',
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
