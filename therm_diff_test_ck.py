# Function to calculate the total thermal diffusion ratio
def calculate_diffusion_ratio(coefficients, Xi, T):
    T2 = T ** 2
    T3 = T ** 3
    diffusion_ratio = 0.0
    for (i, j), (a, b, c, d) in coefficients.items():
        diffusion_ratio += Xi[i] * Xi[j] * (a + b * T + c * T2 + d * T3)
    return diffusion_ratio

# Coefficients for H2 and H from the first dataset
coefficients_first_H2 = {
    (0, 1): (0.443E+00, 0.712E-04, -0.385E-07, 0.686E-11),
    (0, 2): (0.602E-01, 0.562E-03, -0.255E-06, 0.363E-10),
    (0, 3): (-0.153E+00, -0.546E-04, 0.293E-07, -0.487E-11),
    (0, 4): (0.416E+00, 0.110E-04, -0.396E-08, 0.114E-11),
    (0, 5): (0.422E+00, 0.111E-04, -0.402E-08, 0.116E-11),
    (0, 6): (0.444E+00, 0.715E-04, -0.386E-07, 0.689E-11),
    (0, 7): (0.446E+00, 0.717E-04, -0.388E-07, 0.691E-11),
    (0, 8): (0.445E+00, 0.495E-04, -0.263E-07, 0.490E-11)
}

coefficients_first_H = {
    (3, 0): (0.153E+00, 0.546E-04, -0.293E-07, 0.487E-11),
    (3, 1): (0.220E+00, 0.480E-03, -0.233E-06, 0.346E-10),
    (3, 2): (-0.142E+00, 0.767E-03, -0.307E-06, 0.403E-10),
    (3, 4): (0.270E+00, 0.362E-03, -0.181E-06, 0.275E-10),
    (3, 5): (0.272E+00, 0.364E-03, -0.182E-06, 0.277E-10),
    (3, 6): (0.221E+00, 0.481E-03, -0.233E-06, 0.347E-10),
    (3, 7): (0.221E+00, 0.482E-03, -0.234E-06, 0.348E-10),
    (3, 8): (0.241E+00, 0.445E-03, -0.218E-06, 0.327E-10)
}

# Example initial values for Xi
Xi = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]  # Initial values, need normalization

# Normalize Xi values so that their sum equals 1
Xi_sum = sum(Xi)
Xi_normalized = [x / Xi_sum for x in Xi]

# Input the temperature in Kelvin
T = float(input("Enter the temperature in Kelvin: "))

# Calculate the total diffusion ratios
diffusion_ratio_H2 = calculate_diffusion_ratio(coefficients_first_H2, Xi_normalized, T)
diffusion_ratio_H = calculate_diffusion_ratio(coefficients_first_H, Xi_normalized, T)

print(f"Total diffusion ratio for H2 at {T} K: {diffusion_ratio_H2:.6f}")
print(f"Total diffusion ratio for H at {T} K: {diffusion_ratio_H:.6f}")
