# Cross-Paper Consistency Issues
1. Citation format standardization needed:
   - TIMEPROOF.tex uses \bibitem{Houk2017Timezones}
   - PEQUALSNP.tex uses \bibitem{Houk2025Timezones} 
   - MAD.tex missing self-citations entirely
   - Resolution: Choose either "[AuthorYear]" or numeric style universally

2. Temporal references mismatch:
   - TIMEPROOF.tex references "Houk2017Timezones" but TIMEZONE.tex shows 2025 date
   - PEQUALSNP.tex cites "Houk2024Timeproof" while TIMEPROOF.tex is dated 2025
   - Resolution: Update all citations to match actual paper dates

3. Terminology inconsistencies:
   - "Zero-Knowledge Priority" (TIMEPROOF) vs "ZK-Priority Claim Protocol" (TEMPORAL)
   - "VDF-enforced commitments" (TEMPORAL) vs "VDF-based timestamping" (TIMEPROOF)
   - Resolution: Create unified glossary for all papers

4. Mathematical notation alignment:
   - TIMEPROOF uses Weibull(λ,k) while TEMPORAL uses Weibull(α,β)
   - Verification function: V(Δt) vs P(t) across papers
   - Resolution: Standardize notation in all papers

# Cross-Reference Validation
5. Missing cross-citations:
   - TIMEPROOF's "Future Directions" should cite TEMPORAL's AI-Timeproof Protocol
   - EXECUTION.tex references "Timeproof" but lacks \bibitem{Houk2025Timeproof}
   - PEQUALSNP.tex mentions MAD paradox but doesn't cite MAD.tex

6. Bibliography conflicts:
   - Hawking2002 citation appears in both TIMEPROOF.tex and PEQUALSNP.tex with different URLs
   - Cook1971 cited differently in TIMEPROOF (full URL) vs PEQUALSNP (STOC shorthand)

# Structural TODOs
7. Index.html update required:
   - Missing TEMPORAL, EXECUTION, GOVERNANCE, and MAD papers
   - Need to add PEQUALSNP to web index

8. Build system improvements:
   - Add cross-paper citation check to justfile
   - Enable synctex for cross-document linking
   - Implement unified bibtex database for all papers

9. Security consideration alignment:
   - TIMEPROOF mentions quantum resistance while TEMPORAL lacks post-quantum discussion
   - GOVERNANCE.tex needs to reference TIMEPROOF's economic incentives model

10. LaTeX package consistency:
    - PEQUALSNP.tex missing microtype package used in other papers
    - EXECUTION.tex lacks algorithmic packages used in TIMEPROOF 

11. P=NP Proof (PEQUALSNP.tex)
   - Clarify distinction between **probabilistic verification vs. constructive proof**.
   - Expand **M-Theory dimensional analysis** and why \(N \geq 11\) is required.
   - Provide a clearer transition from **Mathematical Assertion Delay (MAD) Paradox** to formal proof methodology.