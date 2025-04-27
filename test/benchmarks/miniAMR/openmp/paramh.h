// ************************************************************************
//
// miniAMR: stencil computations with boundary exchange and AMR.
//
// Copyright (2014) Sandia Corporation. Under the terms of Contract
// DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government 
// retains certain rights in this software.
//
// This library is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2.1 of the
// License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
// Questions? Contact Courtenay T. Vaughan (ctvaugh@sandia.gov)
//                    Richard F. Barrett (rfbarre@sandia.gov)
//
// ************************************************************************
int max_num_blocks = 500;
int num_refine = 5;
int uniform_refine = 0;
int x_block_size = 10;
int y_block_size = 10;
int z_block_size = 10;
int num_vars = 40;
int comm_vars = 0;
int init_block_x = 1;
int init_block_y = 1;
int init_block_z = 1;
int reorder = 1;
int npx = 1;
int npy = 1;
int npz = 1;
int inbalance = 0;
int refine_freq = 5;
int report_diffusion = 0;
int error_tol = 8;
int num_tsteps = 20;
int use_time = 0;
double end_time = 0.0;
int stages_per_ts = 20;
int checksum_freq = 5;
int stencil = 7;
int report_perf = 12;
int plot_freq = 0;
int num_objects = 0;
int lb_opt = 1;
int block_change = 0;
int code = 0;
int permute = 0;
int refine_ghost = 0;
