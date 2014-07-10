C  Copyright (c) 2003-2010 University of Florida
C
C  This program is free software; you can redistribute it and/or modify
C  it under the terms of the GNU General Public License as published by
C  the Free Software Foundation; either version 2 of the License, or
C  (at your option) any later version.

C  This program is distributed in the hope that it will be useful,
C  but WITHOUT ANY WARRANTY; without even the implied warranty of
C  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C  GNU General Public License for more details.

C  The GNU General Public License is included in this distribution
C  in the file COPYRIGHT.
         SUBROUTINE  OED__OVL_DERV_INT1D_TO_00
     +
     +                    ( NEXP,
     +                      INT1DX,INT1DY,INT1DZ,
     +                      DIFFX,DIFFY,DIFFZ,
     +                      SCALE,
     +
     +                                BATCH )
     +
C------------------------------------------------------------------------
C  OPERATION   : OED__OVL_DERV_INT1D_TO_00
C  MODULE      : ONE ELECTRON INTEGRALS DIRECT
C  MODULE-ID   : OED
C  SUBROUTINES : none
C  DESCRIPTION : This routine assembles the set of batches of cartesian
C                derivative overlap integrals [0|0].
C
C                Simplified version of the general AB routine to reduce
C                loop overheads for those cases where only s-shells
C                are involved. For comments and details see the general
C                AB routine.
C
C
C                  Input:
C
C                    NEXP        =  current # of exponent pairs
C                    INT1Dx      =  all current 1D 00 derivative
C                                   nuclear attraction integrals for
C                                   each cartesian component (x = X,Y,Z)
C                    DIFFx       =  is true, if differentiation was
C                                   performed along the x = X,Y,Z
C                                   direction
C                    SCALE       =  the NEXP scaling factors
C
C
C                  Output:
C
C                    BATCH       =  batch of primitive cartesian
C                                   [0|0] derivative overlap integrals
C                                   corresponding to all current
C                                   exponent pairs
C
C
C  AUTHOR      : Norbert Flocke
C------------------------------------------------------------------------
C
C
C             ...include files and declare variables.
C
C
         IMPLICIT    NONE

         LOGICAL     DIFFX,DIFFY,DIFFZ

         INTEGER     N
         INTEGER     NEXP

         DOUBLE PRECISION  SCALE (1:NEXP)
         DOUBLE PRECISION  BATCH (1:NEXP)

         DOUBLE PRECISION  INT1DX (1:NEXP)
         DOUBLE PRECISION  INT1DY (1:NEXP)
         DOUBLE PRECISION  INT1DZ (1:NEXP)
C
C
C------------------------------------------------------------------------
C
C
C             ...skip the multiplication of 1DX integrals, if no
C                x-coordinate derivative was formed, as then the
C                1DX integrals are equal to 1.
C
C
         IF (DIFFX) THEN
             DO N = 1,NEXP
                BATCH (N) = SCALE (N) * INT1DX (N)
             END DO
         ELSE
             DO N = 1,NEXP
                BATCH (N) = SCALE (N)
             END DO
         END IF
C
C
C             ...skip the multiplication of 1DY integrals, if no
C                y-coordinate derivative was formed, as then the
C                1DY integrals are equal to 1. Same with the 1DZ
C                1DZ integrals.
C
C
         IF (DIFFY) THEN
             DO N = 1,NEXP
                BATCH (N) = BATCH (N) * INT1DY (N)
             END DO
         END IF

         IF (DIFFZ) THEN
             DO N = 1,NEXP
                BATCH (N) = BATCH (N) * INT1DZ (N)
             END DO
         END IF
C
C
C             ...ready!
C
C
         RETURN
         END
