;; Chemical Company Verification Contract
;; Manages verification of chemical manufacturers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_COMPANY_EXISTS (err u101))
(define-constant ERR_COMPANY_NOT_FOUND (err u102))

;; Company verification status
(define-map companies
  { company-id: uint }
  {
    name: (string-ascii 100),
    address: (string-ascii 200),
    license-number: (string-ascii 50),
    verified: bool,
    verification-date: uint,
    verifier: principal
  }
)

(define-data-var next-company-id uint u1)

;; Register a new chemical company
(define-public (register-company (name (string-ascii 100)) (address (string-ascii 200)) (license-number (string-ascii 50)))
  (let ((company-id (var-get next-company-id)))
    (asserts! (is-none (map-get? companies { company-id: company-id })) ERR_COMPANY_EXISTS)
    (map-set companies
      { company-id: company-id }
      {
        name: name,
        address: address,
        license-number: license-number,
        verified: false,
        verification-date: u0,
        verifier: tx-sender
      }
    )
    (var-set next-company-id (+ company-id u1))
    (ok company-id)
  )
)

;; Verify a company (only contract owner)
(define-public (verify-company (company-id uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (match (map-get? companies { company-id: company-id })
      company-data
      (begin
        (map-set companies
          { company-id: company-id }
          (merge company-data { verified: true, verification-date: block-height, verifier: tx-sender })
        )
        (ok true)
      )
      ERR_COMPANY_NOT_FOUND
    )
  )
)

;; Get company information
(define-read-only (get-company (company-id uint))
  (map-get? companies { company-id: company-id })
)

;; Check if company is verified
(define-read-only (is-company-verified (company-id uint))
  (match (map-get? companies { company-id: company-id })
    company-data (get verified company-data)
    false
  )
)
