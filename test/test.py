# File: test.py

import cocotb
from cocotb.triggers import Timer
import cocotb.log
import random

@cocotb.test()
async def array_mult_test(dut):
    """Test the 4x4 array multiplier via ui_in and uo_out"""

    # Define the test cases
    test_cases = [
        (1, 1, 1),     # 1 * 1 = 1
        (2, 2, 4),     # 2 * 2 = 4
        (3, 3, 9),     # 3 * 3 = 9
        (4, 4, 16),    # 4 * 4 = 16
        (7, 7, 49),    # 7 * 7 = 49
        (8, 8, 64),    # 8 * 8 = 64
        (15, 15, 225), # 15 * 15 = 225
        (0, 15, 0),    # 0 * 15 = 0
        (15, 0, 0),    # 15 * 0 = 0
        (5, 3, 15),    # 5 * 3 = 15
    ]

    failures = 0

    for m_val, q_val, expected_p in test_cases:
        # Prepare inputs
        ui_in_val = (q_val << 4) | m_val
        dut.ui_in.value = ui_in_val

        # Wait for combinational logic to settle
        await Timer(1, units='ns')

        # Read the output
        p_val = dut.uo_out.value.integer

        # Check if the output matches the expected value
        if p_val != expected_p:
            failures += 1
            dut._log.error(f"Test failed for m={m_val}, q={q_val}: p={p_val}, expected={expected_p}")
        else:
            dut._log.info(f"Test passed for m={m_val}, q={q_val}: p={p_val}")

    if failures == 0:
        dut._log.info("All tests passed")
    else:
        dut._log.error(f"{failures} tests failed")
        assert False, f"{failures} tests failed"
