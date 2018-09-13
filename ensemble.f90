
program main
implicit none
integer i
character(len=150) :: http1,http2,http3,http4
character(len=4) :: year
open(10,file='./ensemble.txt')
http1="http://ensemble.cima.fcen.uba.ar:9090/thredds/fileServer/ensemble/stream2/&
      &seasonal/atmospheric/monthly/132/FC_132_mon_19600201.nc"
http2="http://ensemble.cima.fcen.uba.ar:9090/thredds/fileServer/ensemble/stream2/&
      &seasonal/atmospheric/monthly/132/FC_132_mon_19600501.nc"
http3="http://ensemble.cima.fcen.uba.ar:9090/thredds/fileServer/ensemble/stream2/&
      &seasonal/atmospheric/monthly/132/FC_132_mon_19600801.nc"
http4="http://ensemble.cima.fcen.uba.ar:9090/thredds/fileServer/ensemble/stream2/&
      &seasonal/atmospheric/monthly/132/FC_132_mon_19601101.nc"

do i = 1960,2005
  write(*,*) i
  write(year,"(i4)") i
  write(*,*) "99",year
  http1(119:122) = year
  http2(119:122) = year
  http3(119:122) = year
  http4(119:122) = year
  write(10,"(a137)") http1
  write(10,"(a137)") http2
  write(10,"(a137)") http3
  write(10,"(a137)") http4
end do

close (10)
end
