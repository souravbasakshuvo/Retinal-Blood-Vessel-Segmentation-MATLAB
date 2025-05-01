
# Retinal Blood Vessel Segmentation using Principal Curvature Method in MATLAB

## Overview

This project focuses on the segmentation of retinal blood vessels using the **Principal Curvature Method** in **MATLAB**. Accurate segmentation of retinal blood vessels is critical for the early detection and monitoring of various ocular diseases such as diabetic retinopathy and glaucoma. This project leverages image processing techniques such as Gaussian filtering, contrast enhancement, and morphological operations to segment retinal blood vessels.

## Project Details

- **Course Name**: Biomedical Image Processing Laboratory  
- **Course Number**: BME 4112  
- **Department**: Biomedical Engineering  
- **Institution**: Khulna University of Engineering & Technology (KUET)  
- **Project Submission Date**: 04.06.2023

### Objectives

- Learn different image processing techniques.
- Segment retinal blood vessels from fundus images using the principal curvature method.
- Validate the segmentation results using ground truth images.

### Methodology

The project follows these steps:

1. **Input Image & Ground Truth**: Load the retinal fundus image and corresponding ground truth.
2. **Pre-processing**: Apply Gaussian filtering for noise removal and image smoothing.
3. **Segmentation**: Compute the principal curvature to extract potential vessel regions.
4. **Contrast Enhancement**: Enhance the contrast using CLAHE (Contrast-limited adaptive histogram equalization).
5. **Post-processing**: Use morphological operations to filter small vessel segments.
6. **Validation**: Validate the segmented results by comparing them with the ground truth.

### Software Requirements

- **MATLAB R2020a** or higher

### How to Use

1. Clone the repository:

   ```bash
   git clone https://github.com/souravbasakshuvo/Retinal-Blood-Vessel-Segmentation-MATLAB.git
   ```

2. Navigate to the project folder:

   ```bash
   cd Retinal-Blood-Vessel-Segmentation-MATLAB
   ```

3. Open the MATLAB script `Retinal_Blood_Vessel_Segmentation.m` in MATLAB.

4. Make sure to add the appropriate dataset (input images and ground truth) in the `Data_Set/` folder or modify the path in the script to point to your dataset.

5. Run the script to segment the retinal blood vessels from the provided images.

### Results

The algorithm provides a segmentation accuracy of **96.17%**, with the following metrics:
- **True Positive Rate (TPR)**: 61.89%
- **False Positive Rate (FPR)**: 1.07%
- **Sensitivity**: 61.89%
- **Specificity**: 98.94%

### Key Functions

- `lamdafind()`: Computes the eigenvalues of the Hessian matrix for the principal curvature method.
- `isodata()`: Computes global image threshold using the iterative isodata method for image binarization.

### Files

- **MATLAB Code**: Segmentation algorithm implemented in MATLAB.
- **Data**: Retinal images for testing (input images and ground truth).

### Future Work

- Enhance the accuracy by using more advanced segmentation models.
- Make the algorithm more robust against noise and other artifacts.
- Extend the method to other types of medical imaging like OCT and fluorescein angiography.

## References

1. Techopedia. "Ground Truth." [Techopedia](https://www.techopedia.com/definition/32514/ground-truth)
2. Wikipedia. "Principal Curvature-based Region Detector." [Wikipedia](https://en.wikipedia.org/wiki/Principal_curvature-based_region_detector)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
