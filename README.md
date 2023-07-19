# RobCalib_AXYB

RobCalib_AXYB is a comprehensive toolbox designed to address the AX=YB calibration problem between a robot (hand) and a camera (eye). In this context, X represents the hand-eye relationship, and Y represents the hand-target relationship. This repository serves as the accompanying code for a research paper, providing essential resources for reproducing the results presented therein.

## Overview
The calibration problem between a robot and a camera is a fundamental task in robotics and computer vision. The goal is to determine the transformation between the robot's end-effector (hand) and the camera (eye) coordinate systems, as well as the relationship between the robot's base and the target object (hand-target). RobCalib_AXYB offers various solvers to efficiently tackle this complex problem.

## Features

* Multiple Solvers: RobCalib_AXYB includes a range of solvers, such as LMI-SDP, iterative, and dual quaternion algorithms, to cater to different calibration scenarios.

* MATLAB Implementation: Most of the solvers are implemented using MATLAB, ensuring a user-friendly and well-documented coding environment.

* Python Integration: The core part of the LMI-SDP algorithm is executed in Python, leveraging the PyLMI-SDP library for optimized performance.

* Complete Codebase: The repository contains all the necessary code for simulating and conducting experiments outlined in the associated research paper.

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
3. Run 'Calib_AXYB_test.ipynb':
Before using the code, ensure that you have installed the required dependencies, including PyLMISDP and cvxopt. Then, you can execute the 'Calib_AXYB_test.ipynb' Jupyter Notebook to run the main program.

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
│   ├── ExperimentData
│   ├── sim_solutions
│   ├── solvers
│   ├── tmp_Data
│   ├── util
│   ├── Experimental.m
│   ├── main_Error_datas.m
│   ├── main_Error_noise.m
│   └── plot_main.m
│
├── support_funcs/
│
├── venv (create with pycharm)
│
├── AXYB_Calibrator.py
│
└── Calib_AXYB_test.ipynb
```
waiting......

## Citation

If you find RobCalib_AXYB helpful in your research or use it in academic projects, we kindly request you to acknowledge its usage by citing our paper:

> J. Pan, Z. Fu, H. Yue, X. Lei, M. Li and X. Chen, "Toward Simultaneous Coordinate Calibrations of AX=YB Problem by the LMI-SDP Optimization," in *IEEE Transactions on Automation Science and Engineering*, 2022, [doi: 10.1109/TASE.2022.3207771](https://doi.org/10.1109/TASE.2022.3207771).

## License

RobCalib_AXYB is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the LICENSE file for more details.

## Contribution

We highly appreciate contributions from the community to improve this MaskRCNN-Pytorch repository. You can contribute by submitting issues, feedback, bug fixes, or feature enhancements. Please refer to the repository for detailed contribution guidelines.

We hope you find this repository helpful and encourage you to explore and contribute to its development.