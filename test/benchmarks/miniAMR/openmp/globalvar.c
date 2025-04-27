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
#include "block.h"
#include "timer.h"
#include "mpi.h"
/////////////parac.h
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


///////////timer.h
double average[131]={0};
double stddev[128]={0};
double minimum[128]={0};
double maximum[128]={0};

double timer_all=0;

double timer_comm_all=0;
double timer_comm_dir[3]={0};
double timer_comm_recv[3]={0};
double timer_comm_pack[3]={0};
double timer_comm_send[3]={0};
double timer_comm_same[3]={0};
double timer_comm_diff[3]={0};
double timer_comm_bc[3]={0};
double timer_comm_wait[3]={0};
double timer_comm_unpack[3]={0};

double timer_calc_all=0;

double timer_cs_all=0;
double timer_cs_red=0;
double timer_cs_calc=0;

double timer_refine_all=0;
double timer_refine_co=0;
double timer_refine_mr=0;
double timer_refine_cc=0;
double timer_refine_sb=0;
double timer_refine_c1=0;
double timer_refine_c2=0;
double timer_refine_sy=0;
double timer_cb_all=0;
double timer_cb_cb=0;
double timer_cb_pa=0;
double timer_cb_mv=0;
double timer_cb_un=0;
double timer_lb_all=0;
double timer_lb_sort=0;
double timer_lb_pa=0;
double timer_lb_mv=0;
double timer_lb_un=0;
double timer_lb_misc=0;
double timer_lb_mb=0;
double timer_lb_ma=0;
double timer_rs_all=0;
double timer_rs_ca=0;
double timer_rs_pa=0;
double timer_rs_mv=0;
double timer_rs_un=0;

double timer_plot=0;

long long total_blocks=0;
num_sz nb_min=0;
num_sz nb_max=0;
int nrrs=0;
int nrs=0;
int nps=0;
int nlbs=0;
int num_refined=0;
int num_reformed=0;
int num_moved_all=0;
int num_moved_lb=0;
int num_moved_rs=0;
int num_moved_reduce=0;
int num_moved_coarsen=0;
int counter_halo_recv[3]={0};
int counter_halo_send[3]={0};
double size_mesg_recv[3]={0};
double size_mesg_send[3]={0};
int counter_face_recv[3]={0};
int counter_face_send[3]={0};
int counter_bc[3]={0};
int counter_same[3]={0};
int counter_diff[3]={0};
int counter_malloc=0;
double size_malloc=0;
int counter_malloc_init=0;
double size_malloc_init=0;
int total_red=0;

MPI_Comm *comms;
MPI_Request *request,*s_req;

/////////////////////block.h
block *blocks;
parent *parents;
int *sorted_index;
sorted_block *sorted_list;

int my_pe;
int num_pes=1;

//int max_num_blocks;
//int num_refine;
//int uniform_refine;
//int x_block_size, y_block_size, z_block_size;
//int num_cells;
//int num_vars;
int mat;
//int comm_vars;
//int init_block_x, init_block_y, init_block_z;
//int reorder;
//int npx, npy, npz;
//int inbalance;
//int refine_freq;
//int report_diffusion;
//int checksum_freq;
//int stages_per_ts;
//int error_tol;
//int num_tsteps;
//int stencil;
//int report_perf;
//int plot_freq;
//int lb_opt;
//int block_change;
//int code;
//int permute;
//int refine_ghost;
//int use_time;
//double end_time;

int max_num_parents;
int num_parents;
int max_active_parent;
int cur_max_level;
num_sz *num_blocks;
num_sz *local_num_blocks;
num_sz *block_start;
int num_active;
int max_active_block;
num_sz global_active;
int x_block_half, y_block_half, z_block_half;
double tol;
double *grid_sum;
int *p8, *p2;
int mesh_size[3];
int max_mesh_size;
int *from, *to;
int msg_len[3][4];
int local_max_b;
int global_max_b;
double *alpha, beta;
double total_fp_divs;
double total_fp_adds;
double total_fp_muls;

//int num_objects;
object *objects;

int num_dots;
int max_num_dots;
int max_active_dot;
dot *dots;
