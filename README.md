# Crane Control & State Estimation using LQR/LQG

This repository presents the modeling, analysis, and control of a **cart–double-pendulum crane system**, developed as part of **ENPM667 – Linear Systems Theory**. The project focuses on stabilizing load swing and cart motion using modern control and estimation techniques, validated on both **linearized** and **nonlinear** system models.

---

## 🚧 System Overview

The system consists of:

* A cart (trolley) of mass **M** actuated by a horizontal force **F**
* Two suspended payloads (**m₁**, **m₂**) connected via massless cables of lengths **l₁**, **l₂**

The full system has **6 states**:

```
[x, ẋ, θ₁, θ̇₁, θ₂, θ̇₂]
```

representing cart position/velocity and the angular displacement/velocity of each load.

---

## 🧮 Modeling & Analysis

### Nonlinear Dynamics

* Derived using **Lagrangian mechanics**
* Includes coupled translational and rotational dynamics
* Simulated using `ode45`

### Linearization

* Linearized about the equilibrium point:

  * Cart at rest
  * Small-angle approximation (θ₁ = θ₂ = 0)
* Resulting **state-space model** used for control and estimation design

---

## 🎛️ Control Design

### Controllability Analysis

* Constructed the full controllability matrix
* Verified **full controllability (rank = 6)** for nominal system parameters

### LQR (Linear Quadratic Regulator)

* Designed state-feedback controller to stabilize large initial swing angles
* Tuned using state and control weighting matrices (Q, R)
* Verified stability via closed-loop eigenvalue analysis

---

## 👁️ State Estimation

### Observability Analysis

* Evaluated multiple sensor configurations:

  * Cart position only
  * Load angles only
  * Cart position + one or both load angles
* Identified minimal output sets yielding full observability

### Luenberger Observers

* Designed using pole placement
* Compared estimation performance across different measurement sets

### Kalman Filter / LQG

* Designed **LQG controllers** (LQR + Kalman/LQE estimator)
* Enabled output-feedback control under process and measurement noise

---

## 🔬 Simulation Results

* Compared **open-loop vs closed-loop** responses
* Evaluated controller performance on:

  * Linearized model
  * Full nonlinear dynamics
* Demonstrated:

  * Swing suppression
  * Stable cart positioning
  * Robust state estimation with partial sensing

---

## 📂 Repository Structure

```
.
├── C.m            # Controllability analysis
├── D.m            # LQR design and linear simulation
├── E.m            # Observability analysis for multiple outputs
├── F_Linear.m     # LQR + Luenberger observer (linear system)
├── F_NonLinear.m  # Nonlinear open-loop simulation
├── G_Lin.m        # LQG control on linear system
├── G_NonLin.m     # LQG control on nonlinear system
├── report.pdf     # Project report with derivations and results
└── README.md
```

---

## 🛠️ Tools & Technologies

* MATLAB / Simulink
* State-space modeling
* LQR / LQG control
* Luenberger & Kalman observers
* Nonlinear ODE simulation (`ode45`)

---

## 📌 Key Takeaways

* Demonstrated end-to-end control pipeline from **nonlinear modeling → linearization → control → estimation**
* Highlighted the importance of **sensor selection** for observability
* Validated modern control techniques on a **realistic, underactuated mechanical system**

---

## 📎 References

* ENPM667: Linear Systems Theory (University of Maryland)
* Ogata, *Modern Control Engineering*
* Kailath, *Linear Systems*

---

## ✍️ Author

**Koustubh**
M.Engg. Robotics, University of Maryland

**Aryan Mishra**
M.Engg, University of Maryland

**Rachana Devarapalli**
M.Engg. Robotics, University of Maryland

---

⭐ If you found this project interesting, feel free to star the repository!
