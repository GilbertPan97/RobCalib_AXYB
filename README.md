# RobCalib_AXYB

This repository provides tools for calibrating the hand-eye and hand-target (chessboard) relationship between an image camera and a robot. The calibration method is inspired by the research paper "Toward Simultaneous Coordinate Calibrations of AX=YB Problem by the LMI-SDP Optimization" and includes various algorithms, such as LMI-SDP method, iterative method, and SVD algorithm.

## Features

- **AX**=**YB** calibration between camera and robot (X: hand-eye, Y: hand-target).
- Several calibration algorithms: 
  - Kronecker Product and LMI-SDP-Based Algorithm
  - Iterative Algorithm
  - DQ-Based Algorithm

* Comprehensive simulation and experimental validation programs for accurate calibration assessment.

## Usage Guide

This section describes how to use the project, step by step.

1. Clone the repository to your local machine:
To get started with the code, first, you need to clone the repository to your local machine. You can do this using the following command in your terminal or command prompt:
```
git clone <repository_url>
```
2. Set up Python environment:
We recommend creating a new Python environment using PyCharm or any other preferred method to manage dependencies. For example, to create a new environment named 'venv' and install the required dependencies, you can use the following commands:
For pip-based environment (using virtualenv):
```
python -m venv venv
source venv/bin/activate   # On Windows, use "venv\Scripts\activate" instead
pip install -r requirements.txt
```
Alternatively, if you prefer using Anaconda, you can create and activate the environment as follows:
```
conda create -n lmiSDP python=3.8
conda activate lmiSDP
pip install -r requirements.txt
```
3. Run 'Calib_AXYB_main.ipynb':
Before using the code, ensure that you have installed the required dependencies, including PyLMISDP and cvxopt. Then, you can execute the 'Calib_AXYB_main.ipynb' Jupyter Notebook to run the main program.

```
conda create -n lmiSDP python=3.8
conda activate lmiSDP
pip install -r requirements.txt
```

4. Configuring Matlab LMI solver to call Python interpreter:
If you plan to use the LMI solver written in Matlab that interacts with Python, you need to make a small adjustment in the 'M_Code/solvers/LMI_AXYB.m' file. Modify the python interpreter path in the following line:
```
execommand = 'venv/bin/python AXYB_Calibrator.py';
```
Replace 'venv/bin/python' with the path to your Python interpreter that has the required dependencies installed. For example:
```
execommand = 'C:\path\to\your\python\interpreter\python.exe AXYB_Calibrator.py';
```
By making these changes, you should be able to run the code smoothly and utilize the LMI solver integrated with Python in your Matlab environment.

## Project Structure
The project structure is:

```bash
root/
│
├── M_Code/
│   ├── 
│   └── 
│
├── support_funcs/
│
├── 
│
└── 
```


## Contribution

We highly appreciate contributions from the community to improve this MaskRCNN-Pytorch repository. You can contribute by submitting issues, feedback, bug fixes, or feature enhancements. Please refer to the repository for detailed contribution guidelines.

We hope you find this repository helpful and encourage you to explore and contribute to its development.