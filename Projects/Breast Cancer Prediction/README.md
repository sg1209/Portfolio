# Breat Cancer Prediction

## Project Overview

- This project aims to predict the four response variables: PR.Status, ER Status, HER2 final Status
and Histological type using copy number variation(cn), mutations(mu), gene expression(rs), and protein
levels(pp).

- Among 1963 variables, we will select the top 50 significant predictor variables that classify PR.Status,
ER Status, HER2 final Status, and whether the type is Infiltrating Lobular Carcinoma(ILC) or Infiltrating
Ductal Carcinoma(IDC).

## Key Actions and Techniques


### Research and Analysis:

#### Literature review

- The additional research I read used a bioinformatic approach to subtype the two different Invasive
Breast Cancer. It constructed a particular graph data structure called protein-protein interaction
networks, and it shows the related skeleton of the differentially expressed genes. They analyzed the
critical modules of the networks, which we combined with survival data to identify the unique cancer
genes associated with each breast cancer subtype.

#### Analysis

- Constructed various classification models and evaluated their performances based on accuracy, F1 Score, and AUC using ROC Curve.

### Tools and Technologies

- R: Data analysis and manipulation.

- Machine Learning: Classification models such as Logistic regression, RandomForest, and Support Vector Machine.

## Project Outcomes

- Derived meaningful variables for predictions based on variable importances of the randomforest model.

- Constructed model to predict each parameters used in breat cancer diagnoses.
