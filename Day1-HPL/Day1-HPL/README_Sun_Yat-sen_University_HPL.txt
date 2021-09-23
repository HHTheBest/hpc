Precondition:

module load the cuda10.1 and the openmp3.0.2 which compiled by gcc.
change your host file which suit your nodes in system.

Makefile：

	NULL, we run with binary file.

Running Method:

	HPL/run_2_node_v100x8

The Output file:

	HPL/results/xhpl_8_gpu-ac5.0617.171044-output.txt

The "ompi_info --all" output:

	HPL/opmi_info.txt

Binary file:

	HPL/xhpl_cuda-10.1-dyn_mkl-static_ompi-3.1.3_gcc4.8.5_3-12-19b
	
Result photo:

	HPL.png