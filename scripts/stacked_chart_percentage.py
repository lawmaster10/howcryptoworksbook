#!/usr/bin/env python3
"""
Script to create 100% stacked charts from Curve vs Uniswap data showing market share percentages.
Reads data from input.txt file.
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import os

# Path to the input file
INPUT_FILE = '/Users/lawmaster/Desktop/Code/crypto 201/scripts/input.txt'

def load_data():
    """Load data from the input.txt file"""
    if not os.path.exists(INPUT_FILE):
        raise FileNotFoundError(f"Input file not found: {INPUT_FILE}")
    
    with open(INPUT_FILE, 'r') as f:
        content = f.read()
    
    # Split by lines and filter out empty lines and tab-only lines
    lines = [line.strip() for line in content.split('\n') if line.strip() and line.strip() != '\t']
    
    data = []
    
    # Skip the header section (first 4 lines: month, protocol, monthly_volume, color_hex)
    i = 4  # Start after headers
    
    while i < len(lines):
        # Each record is 4 lines: month, protocol, volume, color
        if i + 3 < len(lines):
            month = lines[i]
            protocol = lines[i + 1]
            volume_str = lines[i + 2]
            color = lines[i + 3]
            
            # Validate and parse the data
            if month and protocol and volume_str and color:
                try:
                    volume = float(volume_str)
                    data.append({
                        'month': month,
                        'protocol': protocol,
                        'monthly_volume': volume,
                        'color_hex': color
                    })
                except ValueError as e:
                    print(f"Skipping invalid volume: {volume_str} - {e}")
            
            i += 4
        else:
            break
    
    print(f"Total records parsed: {len(data)}")
    return pd.DataFrame(data)

def create_percentage_chart():
    """Create a 100% stacked area chart showing market share percentages"""
    # Load data
    df = load_data()
    
    print(f"Loaded DataFrame shape: {df.shape}")
    print(f"DataFrame columns: {df.columns.tolist()}")
    print(f"First few rows:\n{df.head()}")
    
    if df.empty:
        print("ERROR: No data loaded from input.txt")
        return
    
    # Convert month to datetime
    df['month'] = pd.to_datetime(df['month'])
    
    # Pivot the data for stacked chart
    pivot_df = df.pivot(index='month', columns='protocol', values='monthly_volume')
    pivot_df = pivot_df.fillna(0)
    
    # Calculate percentages for each month
    pivot_percentage = pivot_df.div(pivot_df.sum(axis=1), axis=0) * 100
    
    # Get colors for each protocol
    colors = {}
    for protocol in df['protocol'].unique():
        colors[protocol] = df[df['protocol'] == protocol]['color_hex'].iloc[0]
    
    # Create the chart
    fig, ax = plt.subplots(figsize=(12, 8))
    
    # Create 100% stacked area plot
    ax.stackplot(pivot_percentage.index, 
                 *[pivot_percentage[col] for col in pivot_percentage.columns],
                 labels=pivot_percentage.columns,
                 colors=[colors[col] for col in pivot_percentage.columns],
                 alpha=0.8)
    
    # Customize the chart
    ax.set_title('Uniswap vs. Curve Market Share in USDT-USDC swaps\n(Monthly Market Share %)', 
                 fontsize=16, fontweight='bold', pad=20)
    ax.set_xlabel('Month', fontsize=12, fontweight='bold')
    ax.set_ylabel('Market Share (%)', fontsize=12, fontweight='bold')
    
    # Format x-axis
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m'))
    ax.xaxis.set_major_locator(mdates.MonthLocator(interval=1))
    plt.xticks(rotation=45)
    
    # Format y-axis to show percentages
    ax.set_ylim(0, 100)
    ax.yaxis.set_major_formatter(plt.FuncFormatter(lambda x, p: f'{x:.0f}%'))
    
    # Add grid and legend
    ax.grid(True, alpha=0.3)
    ax.legend(loc='upper left', frameon=True, fancybox=True, shadow=True)
    
    # Calculate average market share
    avg_curve = pivot_percentage['Curve (USDT-USDC)'].mean()
    avg_uniswap = pivot_percentage['Uniswap (USDT-USDC)'].mean()
    
    # Add market share statistics
    stats_text = f"Average Market Share:\nCurve: {avg_curve:.1f}%\nUniswap: {avg_uniswap:.1f}%"
    ax.text(0.02, 0.98, stats_text, transform=ax.transAxes, fontsize=10,
            verticalalignment='top', bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8))
    
    plt.tight_layout()
    
    # Save the chart
    output_file = '/Users/lawmaster/Desktop/Code/crypto 201/scripts/curve_vs_uniswap_percentage_chart.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight', facecolor='white')
    print(f"Percentage chart saved to: {output_file}")
    
    # Show the chart
    plt.show()

if __name__ == "__main__":
    print("Creating 100% stacked percentage chart from input.txt...")
    create_percentage_chart()
    print("Done!")
