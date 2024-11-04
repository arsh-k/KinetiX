# Function to calculate Theta_k for a given species (either H2 or H)
def calculate_theta_k(coefficients, Xi, T):
    T2 = T ** 2
    T3 = T ** 3
    theta_k = 0.0
    for (i, j), (a, b, c, d) in coefficients.items():
        theta_k += Xi[i] * Xi[j] * (a + b * T + c * T2 + d * T3)
    return theta_k

# Polynomial coefficients for H2 (Theta_k[0]) and H (Theta_k[3])
coefficients_H2 = {
    (0, 1): (0.43684775065654985, 8.179130716063673e-05, -4.409983424632112e-08, 7.764026096406138e-12),
    (0, 2): (0.07512906602970043, 0.0005821373733232406, -2.789469347324744e-07, 4.1171751399901774e-11),
    (0, 3): (-0.1486831085063039, -6.154097628114892e-05, 3.294695418936562e-08, -5.441105673765522e-12),
    (0, 4): (0.4129006503074195, 1.5890450946719692e-05, -6.619743146725541e-09, 1.577154319581956e-12),
    (0, 5): (0.419209457528095, 1.6133244927245867e-05, -6.720887777403143e-09, 1.6012520356325586e-12),
    (0, 6): (0.43853861830866225, 8.210788948418656e-05, -4.427052754464175e-08, 7.794077620294088e-12),
    (0, 7): (0.44013487621370945, 8.240675795916166e-05, -4.443166997731304e-08, 7.822447660081383e-12),
    (0, 8): (0.4405266841137433, 5.804720964762039e-05, -3.087501886475353e-08, 5.6393973615322755e-12)
}

coefficients_H = {
    (3, 0): (0.1486831085063039, 6.154097628114892e-05, -3.294695418936562e-08, 5.441105673765522e-12),
    (3, 1): (0.18049744191426212, 0.0005560025680354975, -2.731214138716887e-07, 4.100329482121085e-11),
    (3, 2): (-0.20563994325864202, 0.0009145765513564576, -3.9362729466494383e-07, 5.497392297391151e-11),
    (3, 4): (0.2420061080744563, 0.0004133921722127481, -2.079182496265959e-07, 3.180537545971026e-11),
    (3, 5): (0.24382711884890476, 0.00041650280280930093, -2.0948276127547166e-07, 3.20446997157522e-11),
    (3, 6): (0.1808454127330957, 0.0005570744539779636, -2.736479492171055e-07, 4.108234275707603e-11),
    (3, 7): (0.18117335302338639, 0.000558084638074157, -2.741441751782374e-07, 4.115684039202429e-11),
    (3, 8): (0.20452381682016654, 0.0005134692975381282, -2.541366164564522e-07, 3.837080492852087e-11)
}

# Example initial values for Xi
Xi = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]  # Initial values, need normalization

# Normalize Xi values so that their sum equals 1
Xi_sum = sum(Xi)
Xi_normalized = [x / Xi_sum for x in Xi]

# Input the temperature in Kelvin
T = float(input("Enter the temperature in Kelvin: "))

# Calculate Theta_k[0] for H2 and Theta_k[3] for H
theta_k_H2 = calculate_theta_k(coefficients_H2, Xi_normalized, T)
theta_k_H = calculate_theta_k(coefficients_H, Xi_normalized, T)

print(f"Theta_k[0] for H2 at {T} K: {theta_k_H2:.6f}")
print(f"Theta_k[3] for H at {T} K: {theta_k_H:.6f}")
