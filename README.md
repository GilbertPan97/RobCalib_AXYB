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

1. Clone the repository to your local machine
2. Install the dependencies. We recommend using conda to create a new environment with the dependencies installed. For example, create a new conda environment with Python 3.8 installed:

```
conda create -n lmiSDP python=3.8
conda activate lmiSDP
pip install -r requirements.txt
```

3. ......

Please note that the repository provides a basic development workflow example. You can extend and customize it to suit your requirements.

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