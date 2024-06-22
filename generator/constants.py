"""
Module containing definitions of physical constants that are used
in internal routines and are unlikely to need modifying.
"""

# Standard libraries
from sys import float_info

# Local imports
from utils import polynomial_regression


""" A collection of physical constants as defined in Cantera. """
# https://github.com/Cantera/cantera/blob/main/include/cantera/base/ct_defs.h
# Defined Constants
kB = 1.380649e-23  # Boltzmann constant [J/K]
light_speed = 299792458.0  # [m/s]
fine_structure = 7.2973525693e-3  # []
Planck = 6.62607015e-34  # Planck constant [J s]
electron_charge = 1.602176634e-19  # [C]
NA = 6.02214076e23  # Avogadro number [number/mole] - Note: cantera [number/kmol]
Cm_per_Debye = 3.33564e-30  # [C·m] (Coulomb=A⋅s)
J_per_cal = 4.184
one_atm = 1.01325e5  # One atmosphere [Pa]
one_bar = 1.0e5  # One bar [Pa]

# Derived constants
mu0 = 2. * fine_structure * Planck / (electron_charge * electron_charge * light_speed)  # H/m
epsilon0 = 1. / (light_speed * light_speed * mu0)  # F/m
R = kB * NA  # ideal gas constant  [J/mol/K] - Note: cantera [J/kmol/K]

# https://github.com/Cantera/cantera/blob/main/src/thermo/Elements.cpp
standard_atomic_weights = {
    'H': 1.008,
    'He': 4.002602,
    'Li': 6.94,
    'Be': 9.0121831,
    'B': 10.81,
    'C': 12.011,
    'N': 14.007,
    'O': 15.999,
    'F': 18.998403163,
    'Ne': 20.1797,
    'Na': 22.98976928,
    'Mg': 24.305,
    'Al': 26.9815384,
    'Si': 28.085,
    'P': 30.973761998,
    'S': 32.06,
    'Cl': 35.45,
    'Ar': 39.95,
    'K': 39.0983,
    'Ca': 40.078,
    'Sc': 44.955908,
    'Ti': 47.867,
    'V': 50.9415,
    'Cr': 51.9961,
    'Mn': 54.938043,
    'Fe': 55.845,
    'Co': 58.933194,
    'Ni': 58.6934,
    'Cu': 63.546,
    'Zn': 65.38,
    'Ga': 69.723,
    'Ge': 72.63,
    'As': 74.921595,
    'Se': 78.971,
    'Br': 79.904,
    'Kr': 83.798,
    'Rb': 85.4678,
    'Sr': 87.62,
    'Y': 88.90584,
    'Zr': 91.224,
    'Nb': 92.90637,
    'Mo': 95.95,
    'Tc': -1.0,
    'Ru': 101.07,
    'Rh': 102.90549,
    'Pd': 106.42,
    'Ag': 107.8682,
    'Cd': 112.414,
    'In': 114.818,
    'Sn': 118.71,
    'Sb': 121.76,
    'Te': 127.6,
    'I': 126.90447,
    'Xe': 131.293,
    'Cs': 132.90545196,
    'Ba': 137.327,
    'La': 138.90547,
    'Ce': 140.116,
    'Pr': 140.90766,
    'Nd': 144.242,
    'Pm': -1.0,
    'Sm': 150.36,
    'Eu': 151.964,
    'Gd': 157.25,
    'Tb': 158.925354,
    'Dy': 162.5,
    'Ho': 164.930328,
    'Er': 167.259,
    'Tm': 168.934218,
    'Yb': 173.045,
    'Lu': 174.9668,
    'Hf': 178.49,
    'Ta': 180.94788,
    'W': 183.84,
    'Re': 186.207,
    'Os': 190.23,
    'Ir': 192.217,
    'Pt': 195.084,
    'Au': 196.96657,
    'Hg': 200.592,
    'Tl': 204.38,
    'Pb': 207.2,
    'Bi': 208.9804,
    'Po': -1.0,
    'At': -1.0,
    'Rn': -1.0,
    'Fr': -1.0,
    'Ra': -1.0,
    'Ac': -1.0,
    'Th': 232.0377,
    'Pa': 231.03588,
    'U': 238.02891,
    'Np': -1.0,
    'Pu': -1.0,
    'Am': -1.0,
    'Cm': -1.0,
    'Bk': -1.0,
    'Cf': -1.0,
    'Es': -1.0,
    'Fm': -1.0,
    'Md': -1.0,
    'No': -1.0,
    'Lr': -1.0,
    'Rf': -1.0,
    'Db': -1.0,
    'Sg': -1.0,
    'Bh': -1.0,
    'Hs': -1.0,
    'Mt': -1.0,
    'Ds': -1.0,
    'Rg': -1.0,
    'Cn': -1.0,
    'Nh': -1.0,
    'Gl': -1.0,
    'Mc': -1.0,
    'Lv': -1.0,
    'Ts': -1.0,
    'Og': -1.0
}

# https://github.com/Cantera/cantera/blob/main/src/transport/MMCollisionInt.cpp
header_delta_star = [0.0, 0.25, 0.50, 0.75, 1.00, 1.50, 2.00, 2.50]
header_T_star = [
    float_info.epsilon,
    0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
    1.2, 1.4, 1.6, 1.8, 2.0, 2.5, 3.0, 3.5, 4.0, 5.0,
    6.0, 7.0, 8.0, 9.0, 10.0, 12.0, 14.0, 16.0, 18.0,
    20.0, 25.0, 30.0, 35.0, 40.0, 50.0, 75.0, 100.0, 500.0
    ]
collision_integrals_Omega_star_22 = [
    [4.1005, 4.266, 4.833, 5.742, 6.729, 8.624, 10.34, 11.89],
    [3.2626, 3.305, 3.516, 3.914, 4.433, 5.57, 6.637, 7.618],
    [2.8399, 2.836, 2.936, 3.168, 3.511, 4.329, 5.126, 5.874],
    [2.531, 2.522, 2.586, 2.749, 3.004, 3.64, 4.282, 4.895],
    [2.2837, 2.277, 2.329, 2.46, 2.665, 3.187, 3.727, 4.249],
    [2.0838, 2.081, 2.13, 2.243, 2.417, 2.862, 3.329, 3.786],
    [1.922, 1.924, 1.97, 2.072, 2.225, 2.614, 3.028, 3.435],
    [1.7902, 1.795, 1.84, 1.934, 2.07, 2.417, 2.788, 3.156],
    [1.6823, 1.689, 1.733, 1.82, 1.944, 2.258, 2.596, 2.933],
    [1.5929, 1.601, 1.644, 1.725, 1.838, 2.124, 2.435, 2.746],
    [1.4551, 1.465, 1.504, 1.574, 1.67, 1.913, 2.181, 2.451],
    [1.3551, 1.365, 1.4, 1.461, 1.544, 1.754, 1.989, 2.228],
    [1.28, 1.289, 1.321, 1.374, 1.447, 1.63, 1.838, 2.053],
    [1.2219, 1.231, 1.259, 1.306, 1.37, 1.532, 1.718, 1.912],
    [1.1757, 1.184, 1.209, 1.251, 1.307, 1.451, 1.618, 1.795],
    [1.0933, 1.1, 1.119, 1.15, 1.193, 1.304, 1.435, 1.578],
    [1.0388, 1.044, 1.059, 1.083, 1.117, 1.204, 1.31, 1.428],
    [0.99963, 1.004, 1.016, 1.035, 1.062, 1.133, 1.22, 1.319],
    [0.96988, 0.9732, 0.983, 0.9991, 1.021, 1.079, 1.153, 1.236],
    [0.92676, 0.9291, 0.936, 0.9473, 0.9628, 1.005, 1.058, 1.121],
    [0.89616, 0.8979, 0.903, 0.9114, 0.923, 0.9545, 0.9955, 1.044],
    [0.87272, 0.8741, 0.878, 0.8845, 0.8935, 0.9181, 0.9505, 0.9893],
    [0.85379, 0.8549, 0.858, 0.8632, 0.8703, 0.8901, 0.9164, 0.9482],
    [0.83795, 0.8388, 0.8414, 0.8456, 0.8515, 0.8678, 0.8895, 0.916],
    [0.82435, 0.8251, 0.8273, 0.8308, 0.8356, 0.8493, 0.8676, 0.8901],
    [0.80184, 0.8024, 0.8039, 0.8065, 0.8101, 0.8201, 0.8337, 0.8504],
    [0.78363, 0.784, 0.7852, 0.7872, 0.7899, 0.7976, 0.8081, 0.8212],
    [0.76834, 0.7687, 0.7696, 0.7712, 0.7733, 0.7794, 0.7878, 0.7983],
    [0.75518, 0.7554, 0.7562, 0.7575, 0.7592, 0.7642, 0.7711, 0.7797],
    [0.74364, 0.7438, 0.7445, 0.7455, 0.747, 0.7512, 0.7569, 0.7642],
    [0.71982, 0.72, 0.7204, 0.7211, 0.7221, 0.725, 0.7289, 0.7339],
    [0.70097, 0.7011, 0.7014, 0.7019, 0.7026, 0.7047, 0.7076, 0.7112],
    [0.68545, 0.6855, 0.6858, 0.6861, 0.6867, 0.6883, 0.6905, 0.6932],
    [0.67232, 0.6724, 0.6726, 0.6728, 0.6733, 0.6743, 0.6762, 0.6784],
    [0.65099, 0.651, 0.6512, 0.6513, 0.6516, 0.6524, 0.6534, 0.6546],
    [0.61397, 0.6141, 0.6143, 0.6145, 0.6147, 0.6148, 0.6148, 0.6147],
    [0.5887, 0.5889, 0.5894, 0.59, 0.5903, 0.5901, 0.5895, 0.5885],
    ]
collision_integrals_A_star = [
    [1.0065, 1.0840, 1.0840, 1.0840, 1.0840, 1.0840, 1.0840, 1.0840],
    [1.0231, 1.0660, 1.0380, 1.0400, 1.0430, 1.0500, 1.0520, 1.0510],
    [1.0424, 1.0450, 1.0480, 1.0520, 1.0560, 1.0650, 1.0660, 1.0640],
    [1.0719, 1.0670, 1.0600, 1.0550, 1.0580, 1.0680, 1.0710, 1.0710],
    [1.0936, 1.0870, 1.0770, 1.0690, 1.0680, 1.0750, 1.0780, 1.0780],
    [1.1053, 1.0980, 1.0880, 1.0800, 1.0780, 1.0820, 1.0840, 1.0840],
    [1.1104, 1.1040, 1.0960, 1.0890, 1.0860, 1.0890, 1.0900, 1.0900],
    [1.1114, 1.1070, 1.1000, 1.0950, 1.0930, 1.0950, 1.0960, 1.0950],
    [1.1104, 1.1070, 1.1020, 1.0990, 1.0980, 1.1000, 1.1000, 1.0990],
    [1.1086, 1.1060, 1.1020, 1.1010, 1.1010, 1.1050, 1.1050, 1.1040],
    [1.1063, 1.1040, 1.1030, 1.1030, 1.1040, 1.1080, 1.1090, 1.1080],
    [1.1020, 1.1020, 1.1030, 1.1050, 1.1070, 1.1120, 1.1150, 1.1150],
    [1.0985, 1.0990, 1.1010, 1.1040, 1.1080, 1.1150, 1.1190, 1.1200],
    [1.0960, 1.0960, 1.0990, 1.1030, 1.1080, 1.1160, 1.1210, 1.1240],
    [1.0943, 1.0950, 1.0990, 1.1020, 1.1080, 1.1170, 1.1230, 1.1260],
    [1.0934, 1.0940, 1.0970, 1.1020, 1.1070, 1.1160, 1.1230, 1.1280],
    [1.0926, 1.0940, 1.0970, 1.0990, 1.1050, 1.1150, 1.1230, 1.1300],
    [1.0934, 1.0950, 1.0970, 1.0990, 1.1040, 1.1130, 1.1220, 1.1290],
    [1.0948, 1.0960, 1.0980, 1.1000, 1.1030, 1.1120, 1.1190, 1.1270],
    [1.0965, 1.0970, 1.0990, 1.1010, 1.1040, 1.1100, 1.1180, 1.1260],
    [1.0997, 1.1000, 1.1010, 1.1020, 1.1050, 1.1100, 1.1160, 1.1230],
    [1.1025, 1.1030, 1.1040, 1.1050, 1.1060, 1.1100, 1.1150, 1.1210],
    [1.1050, 1.1050, 1.1060, 1.1070, 1.1080, 1.1110, 1.1150, 1.1200],
    [1.1072, 1.1070, 1.1080, 1.1080, 1.1090, 1.1120, 1.1150, 1.1190],
    [1.1091, 1.1090, 1.1090, 1.1100, 1.1110, 1.1130, 1.1150, 1.1190],
    [1.1107, 1.1110, 1.1110, 1.1110, 1.1120, 1.1140, 1.1160, 1.1190],
    [1.1133, 1.1140, 1.1130, 1.1140, 1.1140, 1.1150, 1.1170, 1.1190],
    [1.1154, 1.1150, 1.1160, 1.1160, 1.1160, 1.1170, 1.1180, 1.1200],
    [1.1172, 1.1170, 1.1170, 1.1180, 1.1180, 1.1180, 1.1190, 1.1200],
    [1.1186, 1.1190, 1.1190, 1.1190, 1.1190, 1.1190, 1.1200, 1.1210],
    [1.1199, 1.1200, 1.1200, 1.1200, 1.1200, 1.1210, 1.1210, 1.1220],
    [1.1223, 1.1220, 1.1220, 1.1220, 1.1220, 1.1230, 1.1230, 1.1240],
    [1.1243, 1.1240, 1.1240, 1.1240, 1.1240, 1.1240, 1.1250, 1.1250],
    [1.1259, 1.1260, 1.1260, 1.1260, 1.1260, 1.1260, 1.1260, 1.1260],
    [1.1273, 1.1270, 1.1270, 1.1270, 1.1270, 1.1270, 1.1270, 1.1280],
    [1.1297, 1.1300, 1.1300, 1.1300, 1.1300, 1.1300, 1.1300, 1.1290],
    [1.1339, 1.1340, 1.1340, 1.1350, 1.1350, 1.1340, 1.1340, 1.1320],
    [1.1364, 1.1370, 1.1370, 1.1380, 1.1390, 1.1380, 1.1370, 1.1350],
    [1.14187, 1.14187, 1.14187, 1.14187, 1.14187, 1.14187, 1.14187, 1.14187],
    ]


def polynomial_regression_delta_star(table):
    """
    Perform polynomial regression for each temperature row of collision integrals tables.
    """

    return [polynomial_regression(header_delta_star, T_star_row, degree=6) for T_star_row in table]


Omega_star_22 = polynomial_regression_delta_star(collision_integrals_Omega_star_22)
A_star = polynomial_regression_delta_star(collision_integrals_A_star)
