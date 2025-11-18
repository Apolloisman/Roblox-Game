# Experiment D: Castigliano's Theorem

**MAAE 3202 Mechanics of Solids II**  
**Carleton University**  
**Department of Mechanical & Aerospace Engineering**

---

## 1. OBJECTIVES

To measure the deflections of curved bars in bending and to compare these results with those predicted by Castigliano's theorem.

---

## 2. THEORY

Energy methods are frequently used for analyzing deflections in beams and structures, with Castigliano's theorem being one of the most widely used.

**Castigliano's Theorem:** "If the strain energy of a linearly elastic structure is expressed in terms of the system of external loads, the partial derivative of the strain energy with respect to a concentrated external load is the deflection of the structure at the point of application and in the direction of the load."

**Mathematical Statement:**

If  
$$U = U(P_i)$$

Then  
$$\Delta_i = \frac{\partial U}{\partial P_i}$$

**Where:**
- $U$ is the strain energy of the elastic structure
- $P_i$ is the i-th discrete applied force or moment
- $\Delta_i$ is the deflection (translational if $P_i$ is a force, rotational if $P_i$ is moment) in the same direction and at the point where the load is applied

**Note:** If the deflection is required either at a point where there is no unique point load or in a direction not aligned with the applied load, a dummy or fictitious load may be introduced at the desired point acting in the proper direction. The deflection is obtained by first differentiating U with respect to the dummy load and then taking the limit as the dummy load approaches zero.

---

## 3. APPARATUS

(a) Curved steel bars  
(b) DIDACTEC Deflection of Curved Bars Apparatus, as shown in Figure 1  
(c) Weights

---

## 4. PROCEDURE

The items indicated in the procedure below are with reference to Figure 1.

(a) Release clamp (1) and place specimen (2) in position. Clamp the specimen. Release block (3) and re-position if necessary to suit selected specimen. Lock in required position.

(b) Place special load hanger (4) on the specimen.

(c) Position dial gauge supports so that the dial gauges (5) make contact with the load hanger (4) as shown. Set the dial gauges to zero.

(d) Add weights to the load hanger (4) incrementally, and for each load determine the deflections as measured by the gauges.

---

## 5. REQUIREMENTS

**(a) Graphs:**
- Plot graphs of the measured vertical deflection $v$, and horizontal deflection $u$, versus the vertical end load $W$.

**(b) Calculations:**
- Calculate the theoretical deflection of the curved bar tested using Castigliano's theorem for each load condition. Compare them with the experimentally determined values. Discuss the reasons for any discrepancies between the two sets of results.

**(c) Discussion:**
- Discuss the significance of Castigliano's theorem. What are the limitations of this method? Why is a dummy load required?

---

## 6. THEORETICAL EQUATIONS

### Vertical Deflection ($\Delta_w$):

$$\Delta_w = \frac{W s^3}{3EI} + \frac{WR}{EI}\left(\frac{\pi s^2}{2} + \frac{\pi R^2}{4} + 2sR\right) + \frac{Wd}{EI}(s^2 + 2sR + R^2)$$

### Horizontal Deflection ($\Delta_{\rho_r}$):

$$\Delta_{\rho_r} = \frac{W R^2}{EI}\left[s\left(\frac{\pi}{2} - 1\right) + \frac{R}{2}\right] + \frac{Wd}{EI}\left(sR + R^2 + \frac{sd}{2} + \frac{Rd}{2}\right)$$

**Where:**
- $W$ = Applied vertical load
- $E$ = Young's Modulus
- $I$ = Second moment of area
- $s$ = Horizontal segment length
- $R$ = Radius of curved section
- $d$ = Vertical segment length

---

## 7. MATERIAL PROPERTIES

**Material:** Steel  
**Young's Modulus:** $E = 207$ GPa  
**Cross-section dimensions:**
- Width: $b = 25.4$ mm
- Height: $h = 3.2$ mm

**Second Moment of Area:**
$$I = \frac{bh^3}{12} = \frac{(25.4 \text{ mm})(3.2 \text{ mm})^3}{12}$$

**Hanger mass:** 0.16 kg

---

## 8. SPECIMEN DIMENSIONS

| Specimen (Number) | Dimension s (mm) | Dimension d (mm) | Dimension R (mm) |
|-------------------|------------------|-------------------|------------------|
| 1                 | 75               | 75                | 75               |
| 2                 | 0                | 0                 | 150              |
| 3                 | 0                | 75                | 75               |
| 4                 | 150              | 150               | 0                |

---

## 9. REPORT STRUCTURE CHECKLIST

### Title Page
- [ ] Experiment title: Experiment D: Castigliano's Theorem
- [ ] Date when experiment was performed
- [ ] Name and student number
- [ ] Group number and members

### Report Sections
- [ ] **Objectives** - State the purpose clearly
- [ ] **Apparatus** - Sketch of apparatus with labels (Figure 1)
- [ ] **Procedure** - Reference to manual or modifications
- [ ] **Experimental Data** - All measured parameters in tables
  - [ ] Load values (W)
  - [ ] Vertical deflections (v)
  - [ ] Horizontal deflections (u)
- [ ] **Calculations** - Show methods and sample calculations
  - [ ] Calculate I (second moment of area)
  - [ ] Sample calculation for vertical deflection
  - [ ] Sample calculation for horizontal deflection
  - [ ] Results table with all calculated values
- [ ] **Results** - Present in tables and graphs
  - [ ] Graph: v vs W (experimental)
  - [ ] Graph: u vs W (experimental)
  - [ ] Graph: v vs W (theoretical and experimental comparison)
  - [ ] Graph: u vs W (theoretical and experimental comparison)
  - [ ] Comparison table
- [ ] **Discussion**
  - [ ] Compare experimental vs theoretical results
  - [ ] Explain discrepancies
  - [ ] Discuss significance of Castigliano's theorem
  - [ ] Discuss limitations of the method
  - [ ] Explain why dummy load is required

---

## 10. PRELAB PREPARATION TASKS

1. **Review Theory:**
   - Understand Castigliano's theorem
   - Review energy methods for beam deflection
   - Understand the concept of dummy loads

2. **Prepare Data Tables:**
   - Create table for experimental data (Load, Vertical Deflection, Horizontal Deflection)
   - Create table for theoretical calculations
   - Create comparison table

3. **Prepare Calculation Templates:**
   - Calculate second moment of area (I)
   - Set up vertical deflection equation
   - Set up horizontal deflection equation
   - Identify which specimen you'll be testing

4. **Prepare Graph Templates:**
   - Set up axes for v vs W
   - Set up axes for u vs W
   - Plan for comparison graphs

5. **Draft Report Sections:**
   - Objectives section
   - Theory summary
   - Apparatus sketch (can be done during lab)
   - Procedure outline

---

## NOTES

- Ensure all graphs have labeled axes with variables and units
- All tables must have proper headings with variable names, symbols, and units
- Show units for all calculated results
- Provide at least one sample calculation for each type (vertical and horizontal deflection)
- The discussion should relate to objectives and demonstrate understanding





