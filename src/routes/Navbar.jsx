import { useState, useEffect } from 'react';
import './Navbar.css';

const Navbar = () => {
    const [isOpen, setIsOpen] = useState(false);

    useEffect(() => {
        const handleScroll = () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        };

        window.addEventListener('scroll', handleScroll);
        return () => window.removeEventListener('scroll', handleScroll);
    }, []);

    const toggleMenu = () => {
        setIsOpen(!isOpen);
    };

    const closeMenu = () => {
        setIsOpen(false);
    };

    return (
        <header className="navbar navbar-expand-lg navbar-light">
            <div className="container">
                <a className="navbar-brand" href="#">
                    <img src="https://placehold.co/186x58" alt="Logo" />
                </a>
                
                <button 
                    className="navbar-toggler" 
                    type="button" 
                    onClick={toggleMenu}
                    aria-expanded={isOpen}
                    aria-label="Toggle navigation"
                >
                    <span className="navbar-toggler-icon"></span>
                </button>

                <nav className={`collapse navbar-collapse ${isOpen ? 'show' : ''}`} id="navMenu">
                    <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                        {['Home', 'Product', 'Pricing', 'About', 'Contact'].map(link => (
                            <li className="nav-item" key={link}>
                                <a 
                                    className="nav-link" 
                                    href="#"
                                    onClick={closeMenu}
                                >
                                    {link}
                                </a>
                            </li>
                        ))}
                    </ul>
                    <div className="d-flex">
                        <img src="https://placehold.co/24x24" alt="Twitter" className="me-3" />
                        <img src="https://placehold.co/24x24" alt="Facebook" className="me-3" />
                        <img src="https://placehold.co/24x24" alt="LinkedIn" />
                    </div>
                </nav>
            </div>
        </header>
    );
};

export default Navbar;