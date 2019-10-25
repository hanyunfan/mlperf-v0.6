#!/bin/bash

case "${OMPI_COMM_WORLD_LOCAL_RANK}" in
0)
    export OMPI_MCA_btl_openib_if_include=mlx5_0
    exec "${@}"
    ;;
1)
    export OMPI_MCA_btl_openib_if_include=mlx5_0
    exec "${@}"
    ;;
2)
    export OMPI_MCA_btl_openib_if_include=mlx5_1
    exec "${@}"
    ;;
3)
    export OMPI_MCA_btl_openib_if_include=mlx5_1
    exec "${@}"
    ;;
4)
    export OMPI_MCA_btl_openib_if_include=mlx5_2
    exec "${@}"
    ;;
5)
    export OMPI_MCA_btl_openib_if_include=mlx5_2
    exec "${@}"
    ;;
6)
    export OMPI_MCA_btl_openib_if_include=mlx5_3
    exec "${@}"
    ;;
7)
    export OMPI_MCA_btl_openib_if_include=mlx5_3
    exec "${@}"
    ;;
*)
    echo ==============================================================
    echo "ERROR: Unknown local rank ${OMPI_COMM_WORLD_LOCAL_RANK}"
    echo ==============================================================
    exit 1
    ;;
esac

