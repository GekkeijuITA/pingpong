#!/bin/bash

set -e

if [[ $# != 1 ]] ; then printf "\nERROR: Specify median or overall graph\n" ; exit 1; fi

# Controlliamo che abbia inserito un parametro corretto
if [[ $1 != "median" && $1 != "overall" ]] ; then printf "\nERROR: Specify median or overall graph\n" ; exit 1; fi

# A "GraphType" viene assegnato il primo parametro passato allo script
readonly GraphType=$1

readonly InputTCPDatFile="../data/tcp_throughput.dat"
readonly InputUDPDatFile="../data/udp_throughput.dat"

readonly OutputGraphFile="../data/${GraphType}_delay_graph.png"
readonly OutputDatFile="../data/${GraphType}_delay.dat"

# Controlliamo che i file di input esistano
if [[ ! -r ${InputTCPDatFile} ]]; then
    echo "Cannot read $InputTCPDatFile"
    exit -1
fi

if [[ ! -r ${InputUDPDatFile} ]]; then
    echo "Cannot read $InputUDPDatFile"
    exit -1
fi

# Questa riga serve per cancellare i file di output se esistono già
rm -f "${OutputGraphFile}" "${OutputDatFile}"

# Dichiariamo un array di stringhe
declare -a Protocols=("TCP" "UDP")

if [[ ${GraphType} == "median" ]] ; then
    column=2
else # overall
    column=3
fi

# Iteriamo l'array dei protocolli
for Protocol in "${Protocols[@]}" ; do
    temp_var="Input${Protocol}DatFile"

    BytesMin=$(awk 'NR==1 {print $1}' "${!temp_var}")
    BytesMax=$(awk '{first_column = $1} END {print first_column}' "${!temp_var}")

    # Nei file dat ci sono prima i throughput massimi e poi i minimi
    ThroughputMin=$(awk -v column=${column} '{first_column = $column} END {print first_column}' "${!temp_var}")
    ThroughputMax=$(awk -v column=${column} 'NR==1 {print $column}' "${!temp_var}")

    DelayMin="$(echo "scale=5; (${BytesMin} / 1024) / ${ThroughputMin}" | bc -l)" # La -l indica maggiore precisione nei calcoli
    DelayMax="$(echo "scale=5; (${BytesMax} / 1024) / ${ThroughputMax}" | bc -l)"

    if [[ ${DelayMin} == ${DelayMax} ]] ; then
        B=0;
        L0=0;
    else
        B="$(echo "scale=5; ((${BytesMax} / 1024) - (${BytesMin} / 1024)) / (${DelayMax} - ${DelayMin})" | bc -l)"
        L0="$(echo "scale=5; ${DelayMin} - (${BytesMin} / 1024) / ${ThroughputMin}" | bc -l)"
    fi

    echo -e "${BytesMin} ${DelayMin}\n${BytesMax} ${DelayMax}\n\n" >> "${OutputDatFile}"
done

# Creiamo il grafico
gnuplot <<-eNDgNUPLOTcOMMAND
    set term png size 900, 700
    set output "${OutputGraphFile}"
    set title "${GraphType} delay graph"
    set xlabel "Bytes"
    set ylabel "Delay (msec)"

    set datafile separator whitespace

    set style line 1 \
        linecolor rgb '#0060ad' \
        linetype 1 linewidth 2 \
        pointtype 7 pointsize 1.5

    set style line 2 \
        linecolor rgb '#dd181f' \
        linetype 1 linewidth 2 \
        pointtype 5 pointsize 1.5

    plot "${OutputDatFile}" index 0 with linespoints linestyle 1 title "TCP", \
    ""               index 1 with linespoints linestyle 2 title "UDP"

eNDgNUPLOTcOMMAND