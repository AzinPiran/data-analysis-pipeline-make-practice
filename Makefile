# Default target to build everything: generate report and related files
all: report/count_report.html report/count_report_files

# Target to generate results/isles.dat by counting words in data/isles.txt
results/isles.dat: scripts/wordcount.py data/isles.txt
	# Run wordcount script on isles.txt and save output to results/isles.dat
	python scripts/wordcount.py \
    	--input_file=data/isles.txt \
    	--output_file=results/isles.dat

# Target to generate results/abyss.dat by counting words in data/abyss.txt
results/abyss.dat: scripts/wordcount.py data/abyss.txt
	# Run wordcount script on abyss.txt and save output to results/abyss.dat
	python scripts/wordcount.py \
	    --input_file=data/abyss.txt \
	    --output_file=results/abyss.dat

# Target to generate results/last.dat by counting words in data/last.txt
results/last.dat: scripts/wordcount.py data/last.txt
	# Run wordcount script on last.txt and save output to results/last.dat
	python scripts/wordcount.py \
	    --input_file=data/last.txt \
	    --output_file=results/last.dat

# Target to generate results/sierra.dat by counting words in data/sierra.txt
results/sierra.dat: scripts/wordcount.py data/sierra.txt
	# Run wordcount script on sierra.txt and save output to results/sierra.dat
	python scripts/wordcount.py \
	    --input_file=data/sierra.txt \
	    --output_file=results/sierra.dat

# Target to create the plot for isles using results/isles.dat
results/figure/isles.png: scripts/plotcount.py results/isles.dat
	# Run plotcount script to generate a plot for isles data
	python scripts/plotcount.py \
	    --input_file=results/isles.dat \
	    --output_file=results/figure/isles.png

# Target to create the plot for abyss using results/abyss.dat
results/figure/abyss.png: scripts/plotcount.py results/abyss.dat
	# Run plotcount script to generate a plot for abyss data
	python scripts/plotcount.py \
	    --input_file=results/abyss.dat \
	    --output_file=results/figure/abyss.png

# Target to create the plot for last using results/last.dat
results/figure/last.png: scripts/plotcount.py results/last.dat
	# Run plotcount script to generate a plot for last data
	python scripts/plotcount.py \
	    --input_file=results/last.dat \
	    --output_file=results/figure/last.png

# Target to create the plot for sierra using results/sierra.dat
results/figure/sierra.png: scripts/plotcount.py results/sierra.dat
	# Run plotcount script to generate a plot for sierra data
	python scripts/plotcount.py \
	    --input_file=results/sierra.dat \
	    --output_file=results/figure/sierra.png

# Target to render the report (HTML and associated files) using quarto
report/count_report.html report/count_report_files: results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	# Render the report (count_report.qmd) into HTML format using quarto
	quarto render report/count_report.qmd

# Clean target to remove generated files and reset the environment
clean:
	# Remove all wordcount result files (.dat)
	rm -f results/isles.dat \
		results/abyss.dat \
		results/last.dat \
		results/sierra.dat
	# Remove all generated plot images (.png)
	rm -f results/figure/isles.png \
		results/figure/abyss.png \
		results/figure/last.png \
		results/figure/sierra.png	
	# Remove the generated report and associated files
	rm -rf report/count_report.html \
		report/count_report_files
