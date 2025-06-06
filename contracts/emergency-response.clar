;; Emergency Response Contract
;; Coordinates chemical emergency responses

(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_EMERGENCY_NOT_FOUND (err u501))
(define-constant ERR_INVALID_PRIORITY (err u502))

;; Emergency response data
(define-map emergencies
  { emergency-id: uint }
  {
    company-id: uint,
    incident-id: uint,
    emergency-type: (string-ascii 100),
    priority: uint,  ;; 1-3 scale (1=highest)
    status: (string-ascii 20),
    response-team: principal,
    created-time: uint,
    response-time: uint,
    resolved-time: uint
  }
)

(define-data-var next-emergency-id uint u1)

;; Declare emergency
(define-public (declare-emergency
  (company-id uint)
  (incident-id uint)
  (emergency-type (string-ascii 100))
  (priority uint))
  (let ((emergency-id (var-get next-emergency-id)))
    (asserts! (and (>= priority u1) (<= priority u3)) ERR_INVALID_PRIORITY)
    (map-set emergencies
      { emergency-id: emergency-id }
      {
        company-id: company-id,
        incident-id: incident-id,
        emergency-type: emergency-type,
        priority: priority,
        status: "active",
        response-team: tx-sender,
        created-time: block-height,
        response-time: u0,
        resolved-time: u0
      }
    )
    (var-set next-emergency-id (+ emergency-id u1))
    (ok emergency-id)
  )
)

;; Assign response team
(define-public (assign-response-team (emergency-id uint) (team-leader principal))
  (match (map-get? emergencies { emergency-id: emergency-id })
    emergency-data
    (begin
      (map-set emergencies
        { emergency-id: emergency-id }
        (merge emergency-data {
          response-team: team-leader,
          response-time: block-height,
          status: "responding"
        })
      )
      (ok true)
    )
    ERR_EMERGENCY_NOT_FOUND
  )
)

;; Resolve emergency
(define-public (resolve-emergency (emergency-id uint))
  (match (map-get? emergencies { emergency-id: emergency-id })
    emergency-data
    (begin
      (asserts! (is-eq tx-sender (get response-team emergency-data)) ERR_UNAUTHORIZED)
      (map-set emergencies
        { emergency-id: emergency-id }
        (merge emergency-data {
          status: "resolved",
          resolved-time: block-height
        })
      )
      (ok true)
    )
    ERR_EMERGENCY_NOT_FOUND
  )
)

;; Get emergency information
(define-read-only (get-emergency (emergency-id uint))
  (map-get? emergencies { emergency-id: emergency-id })
)

;; Check if emergency is high priority
(define-read-only (is-high-priority (emergency-id uint))
  (match (map-get? emergencies { emergency-id: emergency-id })
    emergency-data (is-eq (get priority emergency-data) u1)
    false
  )
)

;; Get response time
(define-read-only (get-response-time (emergency-id uint))
  (match (map-get? emergencies { emergency-id: emergency-id })
    emergency-data
    (if (> (get response-time emergency-data) u0)
      (some (- (get response-time emergency-data) (get created-time emergency-data)))
      none
    )
    none
  )
)
