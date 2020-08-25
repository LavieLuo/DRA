# Discriminative Residual Analysis for Image Set Classification With Posture and Age Variations

This is the `Matlab` demo code for **Discriminative Residual Analysis for Image Set Classification With Posture and Age Variations (DRA) (TIP 2020)** **[[IEEE]](https://ieeexplore.ieee.org/document/8911369) [[arXiv]](https://arxiv.org/abs/2008.09994)**


## Overview
*"DRA explores a powerful projection, which casts the residual representations into a discriminant subspace, to magnify the useful information and discriminability of the input space as much as possible."*

![Flowchart](https://github.com/LavieLuo/Datasets/blob/master/DRA_flowchart.png)

**Fig. Flowchart of the DRA method. The subspace learning module aims to make the data in the same class more compact and data between different classes more apart. (a) Raw data space. (b) The projection operation with unrelated group construction. (c) The final embedding space. Specifically, the Distance of Interest (DOI) is defined and employed to form the residual model, which is also taken as the regression error in raw data space.**

## Requirements
- Matlab 2018+

## Dataset
- The dataset should be placed in `./dataset`, e.g.,

  `./database/Cal256-SEResNeXt-50-2048d.mat`

- Download the '.mat' data files from Google Drive:

  LFW:  **[[Gray Croped (10x10)]](https://drive.google.com/open?id=1axFsmNY5ycxqBUow9clrTkZYO5nS11FO)**  **[[Gray Croped (15x10)]](https://drive.google.com/open?id=1SUSgJp3F9vk5zxLUgUMDDQ2fK0NGDI6a)**  **[[Gray Croped (30x15)]](https://drive.google.com/open?id=1Yd3-QgdX6IHYKPVA4VlcoZnoM3EM9mfS)**  **[[VggFace2-Resnet-50 (2048d)]](https://drive.google.com/open?id=15r1IzvSygOpZrs74pYGIsy5UnGYGxi51)**
  
  Caltech-101:  **[[SPM (3000d)]](https://drive.google.com/open?id=1561XOrDjsPJl-DwJfMF3_OL1NZJQfKyE)**  **[[SE-ResNeXt-50 (2048d)]](https://drive.google.com/open?id=15A3jvwUNuGNnthQT6vLg2dYpDOa5W0UR)**
  
  Caltech-256:  **[[SE-ResNeXt-50 (2048d)]](https://drive.google.com/open?id=1561XOrDjsPJl-DwJfMF3_OL1NZJQfKyE)**
  
## Usage
- Run the demo 'Main_LFW.m', 'Main_Cal101.m' and 'Main_Cal256.m'

## Citation
If this repository is helpful for you, please cite our paper:
```
@article{ren2020discriminative,
  title={Discriminative Residual Analysis for Image Set Classification With Posture and Age Variations},
  author={Chuan-Xian Ren, and You-Wei Luo, and Xiao-Lin Xu, and Dao-Qing Dai, and Hong Yan},
  journal={IEEE Transactions on Image Processing},
  year={2020},
  volume={29},
  pages={2875--2888},
  publisher={IEEE},
}
```

## Contact
If you have any questions, please feel free contact me via **luoyw28@mail2.sysu.edu.cn**.
