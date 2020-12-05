uses crt;
procedure entry;
type pembayaran=record
nr:string[5];
nm:string[15];
bl:string[10];
dy:integer;
ml:integer;
mi:integer;
end;
var
sd,ada,td:char;
vf:file of pembayaran;
vr:pembayaran;
x:byte;
vnr:string[5];
begin
assign(vf,'pmb.dat');
{$i-}
reset(vf);
{$i+}
if ioresult<>0 then rewrite (vf);
td:='Y';
while td='Y' do
begin
clrscr;
gotoxy(25,1);write('Entry Pembayaran Listrik');
gotoxy(25,2);write('------------------------');
gotoxy(10,3);write('No.Rek           :');
gotoxy(10,4);write('Nama             :');
gotoxy(10,5);write('Bulan            :');
gotoxy(10,6);write('Daya             :');
gotoxy(10,7);write('Meter Bulan Lalu :');
gotoxy(10,8);write('Meter Bulan Ini  :');
gotoxy(10,9);write('Simpan Data [Y/T]:');
gotoxy(10,10);write('Tambah Data[Y/T]:');
gotoxy(40,3);readln(vnr);
ada:='T';
for x:=1 to filesize(vf) do
begin
seek(vf,x-1);
read(vf,vr);
if vr.nr=vnr then
begin
ada:='Y';
gotoxy(40,4);write(vr.nm);
gotoxy(40,5);write(vr.bl);
gotoxy(40,6);write(vr.dy);
gotoxy(40,7);write(vr.ml);
gotoxy(40,8);write(vr.mi);
end;
end;
if ada='T' then
begin
gotoxy(40,4);readln(vr.nm);
gotoxy(40,5);readln(vr.bl);
gotoxy(40,6);readln(vr.dy);
gotoxy(40,7);readln(vr.ml);
gotoxy(40,8);readln(vr.mi);
gotoxy(40,9);readln(sd);
if (sd='Y') or (sd='y') then
begin
vr.nr:=vnr;
seek(vf,filesize(vf));
write(vf,vr);
end
else
begin
gotoxy(10,14);write('Data sudah Disimpan');
end;
end
else
begin
gotoxy(10,14);write('Data Sudah ada');
end;
gotoxy(40,10);readln(td);
end;
close(vf);
end;

procedure laporan;
type pembayaran=record
nr:string[5];
nm:string[15];
bl:string[10];
dy:integer;
ml:integer;
mi:integer;
end;
var
vf:file of pembayaran;
vr:pembayaran;
x,br:byte;
tpb:real;
hg,bb,pb:real;
pk:real;
begin
assign(vf,'pmb.dat');
reset(vf);
clrscr;
gotoxy(25,1);write('Laporan Data Pembayaran Listrik');
gotoxy(1,2);write('---------------------------------------------------------------------------');
gotoxy(1,3);write('|No|No.Rek|Nama           | Mbl | Mbi |Pakai|Daya|Beban |Harga |Pembayaran|');
gotoxy(1,4);write('|  |      |               |     |     |     |    |      |/Kwh  |          |');
gotoxy(1,5);write('---------------------------------------------------------------------------');
                   {5678901234567890123456789012345678901234567890123456789012}
                   { 1    2     3    4   5   6     7    8     9      0        }
br:=6;
for x:=1 to filesize(vf) do
begin
seek(vf,x-1);
read(vf,vr);
gotoxy(1,br);write('|',x);
gotoxy(4,br);write('|',vr.nr);
gotoxy(11,br);write('|',vr.nm);
gotoxy(27,br);write('|',vr.ml);
gotoxy(33,br);write('|',vr.mi);
pk:=vr.mi-vr.ml;
gotoxy(39,br);write('|',pk:3:0);
gotoxy(45,br);write('|',vr.dy);
if (vr.dy=450) then
begin
hg:=250;
bb:=25000;
end
else
if (vr.dy=900) then
begin
hg:=400;
bb:=30000;
end
else
if (vr.dy=1200) then
begin
hg:=500;
bb:=50000;
end;
gotoxy(50,br);write('|',bb:5:0);
gotoxy(57,br);write('|',hg:6:0);
pb:=(pk*hg)+bb;
tpb:=tpb+pb;
gotoxy(64,br);write('|',pb:6:0);
gotoxy(75,br);write('|');
br:=br+1;
end;
gotoxy(1,br);write('---------------------------------------------------------------------------');
br:=br+1;
gotoxy(1,br);write('|    Total');
gotoxy(64,br);write('|',tpb:8:0);readln;
gotoxy(75,br);write('|');
br:=br+1;
gotoxy(1,br);write('---------------------------------------------------------------------------');
close(vf);
readln
end;

procedure laporan2;
type pembayaran=record
nr:string[5];
nm:string[15];
bl:string[10];
dy:integer;
ml:integer;
mi:integer;
end;
var
vf:file of pembayaran;
vr:pembayaran;
x,br:byte;
tpb:real;
hg,bb,pb:real;
pk:real;
tpk:REAL;
max:REAL;
min:REAL;
nm:string[15];
nr:string[10];
nra:string[10];
nrb:string[10];
nrc:string[10];

begin
assign(vf,'pmb.dat');
reset(vf);
clrscr;
gotoxy(25,1);write('Laporan Data Pembayaran Listrik');
gotoxy(1,2);write('---------------------------------------------------------------------------');
gotoxy(1,3);write('|No|No.Rek|Nama           | Mbl | Mbi |Pakai|Daya|Beban |Harga |Pembayaran|');
gotoxy(1,4);write('|  |      |               |     |     |     |    |      |/Kwh  |          |');
gotoxy(1,5);write('---------------------------------------------------------------------------');
                   {5678901234567890123456789012345678901234567890123456789012}
                   { 1    2     3    4   5   6     7    8     9      0        }
br:=6;
max:=0;
min:=1000000;

for x:=1 to filesize(vf) do
begin
seek(vf,x-1);
read(vf,vr);
gotoxy(1,br);write('|',x);
gotoxy(4,br);write('|',vr.nr);
gotoxy(11,br);write('|',vr.nm);
gotoxy(27,br);write('|',vr.ml);
gotoxy(33,br);write('|',vr.mi);
pk:=vr.mi-vr.ml;
gotoxy(39,br);write('|',pk:3:0);
gotoxy(45,br);write('|',vr.dy);
if (vr.dy=450) then
begin
hg:=250;
bb:=25000;
end
else
if (vr.dy=900) then
begin
hg:=400;
bb:=30000;
end
else
if (vr.dy=1200) then
begin
hg:=500;
bb:=50000;
end;
gotoxy(50,br);write('|',bb:5:0);
gotoxy(57,br);write('|',hg:6:0);
pb:=(pk*hg)+bb;
tpk:=tpk+pk;
tpb:=tpb+pb;
if (pb>max) then
begin
MAX:=PB;
nr:=vr.nr;
nra:=vr.nm;
END;
if (pb<min) then
BEGIN
MIN:=PB;
nrb:=vr.nr;
nrc:=vr.nm;
end;

gotoxy(64,br);write('|',pb:6:0);

gotoxy(75,br);write('|');
br:=br+1;
end;
gotoxy(1,br);write('---------------------------------------------------------------------------');
br:=br+1;
gotoxy(1,br);write('|    Total');
gotoxy(39,br);write('|',tpk:4:0);readln;
gotoxy(45,br);write('|');
gotoxy(64,br);write('|',tpb:8:0);readln;
gotoxy(75,br);write('|');
br:=br+1;
gotoxy(1,br);write('---------------------------------------------------------------------------');
br:=br+1;
gotoxy(1,br);write('|    Pembayaran');
gotoxy(28,br);write('Tertinggi');
gotoxy(57,br);write('Terendah          |');

br:=br+1;
gotoxy(1,br);write('|           Norek.');
gotoxy(28,br);write(nr);
gotoxy(57,br);write(nrb);
gotoxy(75,br);write('|');
br:=br+1;
gotoxy(1,br);write('|           Nama');
gotoxy(28,br);write(nra);
gotoxy(57,br);write(nrc);
gotoxy(75,br);write('|');

br:=br+1;
gotoxy(1,br);write('---------------------------------------------------------------------------');

close(vf);
readln
end;
procedure laporan3;
type pembayaran=record
nr:string[5];
nm:string[15];
bl:string[10];
dy:integer;
ml:integer;
mi:integer;
end;
var
dy:integer;
vf:file of pembayaran;
vr:pembayaran;
x,br:byte;
tpb:real;
hg,bb,pb:real;
pk:real;
tpk:REAL;
max:REAL;
min:REAL;
nm:string[15];
nr:string[10];
nra:string[10];
nrb:string[10];
nrc:string[10];

begin
assign(vf,'pmb.dat');
reset(vf);
clrscr;
gotoxy(25,1);write('Laporan Data Pembayaran Listrik');
gotoxy(10,2);write('Daya:');readln(dy);
if (dy=450) then
begin
hg:=250;
bb:=25000;
end
else
if (dy=900) then
begin
hg:=400;
bb:=30000;
end
else
if (dy=1200) then
begin
hg:=500;
bb:=50000;
end;
gotoxy(50,2);write('Beban:');
gotoxy(55,2);write(bb:6:0);

gotoxy(1,3);write('-----------------------------------------------------------------');
gotoxy(1,4);write('|No|No.Rek|Nama           | Mbl | Mbi |Pakai|Harga |Pembayaran  |');
gotoxy(1,5);write('|  |      |               |     |     |     |/Kwh  |            |');
gotoxy(1,6);write('-----------------------------------------------------------------');
                   {5678901234567890123456789012345678901234567890123456789012}
                   { 1    2     3    4   5   6     7    8     9      0        }
br:=7;
max:=0;
min:=1000000;

for x:=1 to filesize(vf) do
begin
seek(vf,x-1);
read(vf,vr);
if dy=vr.dy then
begin
gotoxy(1,br);write('|',x);
gotoxy(4,br);write('|',vr.nr);
gotoxy(11,br);write('|',vr.nm);
gotoxy(27,br);write('|',vr.ml);
gotoxy(33,br);write('|',vr.mi);
pk:=vr.mi-vr.ml;
gotoxy(39,br);write('|',pk:3:0);
gotoxy(45,br);write('|',hg:4:0);
pb:=(pk*hg)+bb;
tpk:=0+pk;
tpb:=0+pb;
if (pb>max) then
begin
MAX:=PB;
nr:=vr.nr;
nra:=vr.nm;
END;
if (pb<min) then
BEGIN
MIN:=PB;
nrb:=vr.nr;
nrc:=vr.nm;
end;
gotoxy(52,br);write('|',pb:8:0);
gotoxy(65,br);write('|');
br:=br+1;
end;
end;
gotoxy(1,br);write('-----------------------------------------------------------------');
br:=br+1;
gotoxy(5,br);write('Total');
gotoxy(39,br);write('|',tpk:4:0);readln;
gotoxy(45,br);write('|');
gotoxy(52,br);write('|',tpb:8:0);readln;
gotoxy(65,br);write('|');
br:=br+1;
gotoxy(1,br);write('-----------------------------------------------------------------');
br:=br+1;
gotoxy(1,br);write('| Pembayaran');
gotoxy(28,br);write('Tertinggi');
gotoxy(57,br);write('Terendah|');
br:=br+1;
gotoxy(1,br);write('|          Norek.');
gotoxy(28,br);write(nr);
gotoxy(57,br);write(nrb);
gotoxy(65,br);write('|');
br:=br+1;
gotoxy(1,br);write('|          Nama');
gotoxy(28,br);write(nra);
gotoxy(57,br);write(nrc);
gotoxy(65,br);write('|');

br:=br+1;
gotoxy(1,br);write('-----------------------------------------------------------------');

close(vf);
readln
end;

var pilih:byte;
begin
PILIH:=0;
while pilih<4 do
begin
clrscr;
gotoxy(10,1);write('----------------------------------------------');
gotoxy(10,2);write('|               Menu Laporan                 |');
gotoxy(10,3);write('----------------------------------------------');
gotoxy(10,4);write('|[1] ENTRY                                   |');
gotoxy(10,5);write('|[2] LAPORAN                                 |');
gotoxy(10,6);write('|[3] LAPORAN 2                               |');
gotoxy(10,7);write('|[4] LAPORAN 3                                |');
gotoxy(10,8);write('|[5] EXit                                    |');
gotoxy(10,9);write('----------------------------------------------');
gotoxy(10,10);write('|Input Pilihan[1-5]:                         |');
gotoxy(10,11);write('----------------------------------------------');
gotoxy(30,10);readln(pilih);
if pilih=1 then ENTRY
else
if pilih=2 then LAPORAN
else
if pilih=3 then LAPORAN2
else
if pilih=4 then LAPORAN3
end;
end.



