# American Options Valuation: Least-Squares Monte Carlo (LSM)

## Table of Contents
- [Description](#description)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Project Structure](#project_structure)
- [References](#references)

## Description
This project implements the Least-Squares Monte Carlo (LSM) approach to value American options. It provides a flexible and efficient method to handle early exercise features of American options. The project is fully implemented in MATLAB. This project is part of the coursework for York University's Mathematics graduate course, MATH 6911 Numerical Methods in Finance.

## Features
- Simulates American option pricing using the LSM method.
- Flexible configuration of parameters such as volatility, risk-free rate, and strike price.
- Implemented in MATLAB for numerical analysis.

## Prerequisites
- MATLAB

## Project Structure
- `solve_BS_American_LSM.m`: Main script for option valuation
- `check_BS_American_LSM.m`: Example of input 
- `laguerreL_optimized.m`: Calculate Laguerre polynomials, requires for `solve_BS_American_LSM.m`
- `solve_Black_Scholes_explicit_am_option.m`: Pricing Black Scholes American options using explicit finite difference methods

## References
- Longstaff, F. A., & Schwartz, E. S. (2001). Valuing American Options by Simulation: A Simple Least-Squares Approach. The Review of Financial Studies, 14(1), 113–147.
