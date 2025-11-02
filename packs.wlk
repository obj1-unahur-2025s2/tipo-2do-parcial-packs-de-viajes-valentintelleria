// completar
class Pack {
    const property duracion
    const property beneficiosEspeciales = []
    const property cordinador
    var precio

    method valorFinal() {
        return precio + (beneficiosEspeciales.sum({b => b.costo()}))
    }

    method precio() = precio

    method esPackPremium() {
        return self.condicionPremium()
    }

    method condicionPremium()
}

class BeneficioEspecial {
    const property tipo
    const property costo
    const property estaVigente
}

class PackNacional inherits Pack {
    const property provincia
    var actividades = #{}

    method actividades() = actividades

    override method condicionPremium() {
        return self.duracion() > 10 && self.cordinador().esAltamenteCalificado()
    }
}

class PackProvincial inherits PackNacional {
    const property cantCiudadesAVisitar

    override method condicionPremium() {
        return (self.actividades().size() >= 4) && (self.cantCiudadesAVisitar() > 5) && (self.beneficiosEspeciales().size() >= 3) 
    }

    override method valorFinal() {
        return super() + 
        if (self.condicionPremium()) {
            return (super() * 0.05)
        } else {
            return 0
        }
    }
}

class PackInternacional inherits Pack {
    const property pais
    const property escalas
    const property esDeInteres

    override method valorFinal() {
        return super() + (super() * 0.2)
    }

    override method condicionPremium() {
        return self.esDeInteres() && self.duracion() > 20 && self.escalas() == 0
    }
}
class Cordinador {
    const property viajesRealizados
    const property estaMotivado
    const property aniosExperiencia
    var rol

    method rol() = rol

    method cambiarARol(unRol) {
            if (unRol == guia || unRol == asistenteLogistico || unRol == acompaniante) {
                rol = unRol
            } else {
                self.error("rol no existente")
            }
    }

    method esAltamenteCalificado() = self.realizoAlMenos20Viajes() && self.cumpleSuRol()

    method realizoAlMenos20Viajes() = viajesRealizados > 20

    method cumpleSuRol() {
        return ( (self.rol() == guia && estaMotivado) || (self.rol() == asistenteLogistico && self.aniosExperiencia() >= 3) || (self.rol() == acompaniante) ) 
    }
}
object guia {}
object asistenteLogistico{}
object acompaniante {}


