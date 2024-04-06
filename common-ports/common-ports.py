import argparse
from typing import List

class Service:
    def __init__(self, name: str, port_protocol: str, frequency: float, comments: str):
        self.name = name
        self.port_protocol = port_protocol
        self.frequency = frequency
        self.comments = comments
        # Initialize these as False; they will be set based on user input
        self.include_name = False
        self.include_frequency = False
        self.include_comments = False

    @property
    def port(self) -> int:
        return int(self.port_protocol.split('/')[0])

    @property
    def protocol(self) -> str:
        return self.port_protocol.split('/')[1]

    def detailed_str(self) -> str:
        details = [f"{self.port}"]
        if self.include_name:
            details.append(f"Service: {self.name}")
        if self.include_frequency:
            details.append(f"Frequency: {self.frequency}")
        if self.include_comments and self.comments:
            details.append(f"Comments: {self.comments}")
        return ", ".join(details)

class ServiceParser:
    def __init__(self):
        # Hardcoded file path for the Nmap services file
        self.file_path = 'provider.txt'
        self.services = []

    def parse(self) -> None:
        with open(self.file_path, 'r') as file:
            for line in file:
                if line.startswith('#') or not line.strip():
                    continue
                parts = line.split()
                if len(parts) < 3:
                    continue
                name = parts[0]
                port_protocol = parts[1]
                frequency = float(parts[2])
                comments = " ".join(parts[3:]) if len(parts) > 3 else ""
                self.services.append(Service(name, port_protocol, frequency, comments))

    def get_top_services(self, protocol: str, top_n: int, include_name=False, include_frequency=False, include_comments=False) -> List[Service]:
        filtered_services = [s for s in self.services if s.protocol == protocol]
        sorted_services = sorted(filtered_services, key=lambda x: x.frequency, reverse=True)[:top_n]
        for service in sorted_services:
            service.include_name = include_name
            service.include_frequency = include_frequency
            service.include_comments = include_comments
        return sorted_services

def main():
    parser = argparse.ArgumentParser(description="Parse Nmap Services File")
    parser.add_argument("--protocol", choices=['tcp', 'udp'], default='tcp', help="Protocol type (tcp/udp)")
    parser.add_argument("--top", type=int, default=5000, help="Number of top ports to list")
    parser.add_argument("--service_name", action="store_true", help="Include service names in the output")
    parser.add_argument("--frequency", action="store_true", help="Include open frequencies in the output")
    parser.add_argument("--comments", action="store_true", help="Include comments in the output")
    parser.add_argument("--save", type=str, help="File to save output")
    args = parser.parse_args()

    service_parser = ServiceParser()
    service_parser.parse()
    top_services = service_parser.get_top_services(args.protocol, args.top, args.service_name, args.frequency, args.comments)

    output_lines = [service.detailed_str() for service in top_services]
    output_str = "\n".join(output_lines) if args.service_name or args.frequency or args.comments else ",".join([str(service.port) for service in top_services])

    if args.save:
        with open(args.save, 'w') as file:
            file.write(output_str)
            print(f"Output saved to {args.save}")
    else:
        print(output_str)

if __name__ == "__main__":
    main()
