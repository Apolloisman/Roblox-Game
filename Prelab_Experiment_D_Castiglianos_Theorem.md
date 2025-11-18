**PROJECT TITLE: MAAE 3202 – Lab D: Castigliano's Theorem**

**Experiment Title: Castigliano's Theorem**

Date Performed: [Date]   
Author: Tyler Johnston, Student \#101257037   
Lab Section MAAE 3202A, [Section], [Group] 

Group Members:   
1\.   Tyler Johnston (\#101257037)   
2\.   [Name] (\#[Student Number])   
3\.   [Name] (\#[Student Number])   
4\.   [Name] (\#[Student Number])   
Location: [Location] [Time]   
TA Signature \_\_\_\_\_\_\_\_\_\_\_\_.

**1.0 BACKGROUND**

Energy methods are frequently used for analyzing deflections in beams and structures, with Castigliano's theorem being one of the most widely used methods. Castigliano's theorem states that if the strain energy of a linearly elastic structure is expressed in terms of the system of external loads, the partial derivative of the strain energy with respect to a concentrated external load is the deflection of the structure at the point of application and in the direction of the load. Mathematically, if $U = U(P_i)$, then $\Delta_i = \frac{\partial U}{\partial P_i}$, where $U$ is the strain energy, $P_i$ is the i-th discrete applied force or moment, and $\Delta_i$ is the deflection at the point where the load is applied. If the deflection is required at a point where there is no unique point load or in a direction not aligned with the applied load, a dummy or fictitious load may be introduced at the desired point acting in the proper direction. This experiment aims to measure the deflections of curved bars in bending and compare these results with those predicted by Castigliano's theorem.

**2.0 OBJECTIVES**

The primary objective of this experiment is to measure the deflections of curved bars in bending and to compare these results with those predicted by Castigliano's theorem. This will be achieved by applying incremental loads to a curved bar specimen and measuring both vertical and horizontal deflections using dial gauges. Through analysis of the deflection data, the experimental results will be compared with theoretical predictions calculated using Castigliano's theorem, and any discrepancies or experimental errors will be thoroughly discussed.

**3.0 APPARATUS**

The following equipment is required:

* (a) Curved steel bars   
* (b) DIDACTEC Deflection of Curved Bars Apparatus, as shown in Figure 1   
* (c) Weights   
* (d) Two dial gauges

**Figure 1: DIDACTEC Deflection of Curved Bars Apparatus**
*(Note: Sketch to be completed during lab session)*

**3.1 Procedure**  
The procedure is the same as outlined in lab manual section 4, experiment D, Castigliano's theorem for MAAE 3202\.

* **Set up:**  
  * Release clamp (1) and place specimen (2) in position. Clamp the specimen.  
  * Release block (3) and re-position if necessary to suit selected specimen. Lock in required position.  
  * Place special load hanger (4) on the specimen.  
  * Position dial gauge supports so that the dial gauges (5) make contact with the load hanger (4) as shown. Set the dial gauges to zero.  
  * Add weights to the load hanger (4) incrementally, and for each load determine the deflections as measured by the gauges.

**4.0 PRELAB CALCULATIONS**

**Given Dimensions from Lab Manual:**  
**Material: Steel with $E = 207$ GPa**  
**Cross-section dimensions: $b = 25.4$ mm and $h = 3.2$ mm**  
**Hanger: 0.16 kg**

**Second Moment of Area Calculation:**  
$I = \frac{bh^3}{12}$ \hspace{2em} [1]  
$I = \frac{(25.4 \text{ mm})(3.2 \text{ mm})^3}{12} = \frac{(25.4)(32.768)}{12} = 69.33 \text{ mm}^4$ \hspace{2em} [2]

**Product $EI$:**  
$EI = (207,000 \text{ N/mm}^2)(69.33 \text{ mm}^4) = 14.35 \times 10^6 \text{ N·mm}^2$ \hspace{2em} [3]

**Specimen Dimensions:**

| Specimen (Number) | Dimension $s$ (mm) | Dimension $d$ (mm) | Dimension $R$ (mm) |
| :---- | :---- | :---- | :---- |
| 1 | 75 | 75 | 75 |
| 2 | 0 | 0 | 150 |
| 3 | 0 | 75 | 75 |
| 4 | 150 | 150 | 0 |

**My Specimen:** \_\_\_\_\_\_\_\_\_\_\_\_ (Circle above)

**Theoretical Deflection Equations:**

**Vertical Deflection ($\Delta_w$):**  
$\Delta_w = \frac{W s^3}{3EI} + \frac{WR}{EI}\left(\frac{\pi s^2}{2} + \frac{\pi R^2}{4} + 2sR\right) + \frac{Wd}{EI}(s^2 + 2sR + R^2)$ \hspace{2em} [4]

**Horizontal Deflection ($\Delta_{\rho_r}$):**  
$\Delta_{\rho_r} = \frac{WR^2}{EI}\left[s\left(\frac{\pi}{2} - 1\right) + \frac{R}{2}\right] + \frac{Wd}{EI}\left(sR + R^2 + \frac{sd}{2} + \frac{Rd}{2}\right)$ \hspace{2em} [5]

**Where:**  
$W$ = applied vertical load  
$E$ = Young's Modulus (207,000 N/mm²)  
$I$ = second moment of area (69.33 mm⁴)  
$s$ = horizontal segment length  
$R$ = radius of curved section  
$d$ = vertical segment length

**Simplified Deflection Coefficients:**

For each specimen, deflections can be written as $\Delta = \frac{W \times C}{EI}$ where $C$ is a constant coefficient:

| Specimen | $s$ (mm) | $d$ (mm) | $R$ (mm) | $C_w$ (vertical, mm³) | $C_{\rho_r}$ (horizontal, mm³) |
| :---- | :---- | :---- | :---- | :---- | :---- |
| 1 | 75 | 75 | 75 | $3.67 \times 10^6$ | $1.40 \times 10^6$ |
| 2 | 0 | 0 | 150 | $2.65 \times 10^6$ | $1.69 \times 10^6$ |
| 3 | 0 | 75 | 75 | $1.11 \times 10^6$ | $0.70 \times 10^6$ |
| 4 | 150 | 150 | 0 | $11.25 \times 10^6$ | 0 |

**Example Calculation for Specimen 1 with $W = 10$ N:**

$\Delta_w = \frac{W \times C_w}{EI} = \frac{(10 \text{ N})(3.67 \times 10^6 \text{ mm}^3)}{14.35 \times 10^6 \text{ N·mm}^2} = 2.56 \text{ mm}$ \hspace{2em} [6]

$\Delta_{\rho_r} = \frac{W \times C_{\rho_r}}{EI} = \frac{(10 \text{ N})(1.40 \times 10^6 \text{ mm}^3)}{14.35 \times 10^6 \text{ N·mm}^2} = 0.98 \text{ mm}$ \hspace{2em} [7]

**5.0 DATA COLLECTION TABLES**

**Table 1: Experimental Data for Deflection of Curved Bar Under Bending**

| Load $W$ (N) | Vertical Deflection $v$ (mm) | Horizontal Deflection $u$ (mm) | Notes |
| :---- | :---- | :---- | :---- |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

**Table 2: Theoretical Deflection Calculations**

| Load $W$ (N) | $\Delta_w$ (mm) | $\Delta_{\rho_r}$ (mm) | Experimental $v$ (mm) | Experimental $u$ (mm) |
| :---- | :---- | :---- | :---- | :---- |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

**6.0 REPORT REQUIREMENTS**

**(a) Graphs:**  
Plot graphs of the measured vertical deflection $v$, and horizontal deflection $u$, versus the vertical end load $W$.

**(b) Calculations:**  
Calculate the theoretical deflection of the curved bar tested using Castigliano's theorem for each load condition. Compare them with the experimentally determined values. Discuss the reasons for any discrepancies between the two sets of results.

**(c) Discussion:**  
Discuss the significance of Castigliano's theorem. What are the limitations of this method? Why is a dummy load required?

**7.0 REFERENCES**   
   
\[1\] Department of Mechanical and Aerospace Engineering, MAAE3202 Mechanics of Solids II Laboratory Manual, Available via Brightspace, Carleton University, 2025\.   
\[2\] R. C. Hibbeler, Mechanics of Materials, 11th. Pearson, 2023





